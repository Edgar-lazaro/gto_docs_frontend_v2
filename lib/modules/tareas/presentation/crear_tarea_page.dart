import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/auth/auth_providers.dart';
import '../../../core/auth/role_utils.dart';
import '../../../core/users/users_providers.dart';
import '../../../core/users/user_ref.dart';
import '../../tickets_glpi/domain/glpi_ticket.dart';
import '../../tickets_glpi/domain/glpi_ticket_user.dart';
import '../../tickets_glpi/presentation/glpi_providers.dart';
import '../../../shared/ui/theme/gerencia_config.dart';
import '../../../shared/ui/widgets/section_container.dart';
import '../domain/tarea.dart';
import 'tareas_providers.dart';

class CrearTareaPage extends ConsumerStatefulWidget {
  final GerenciaTheme theme;
  final String creadoPor;
  final String? fixedAsignadoA;

  const CrearTareaPage({
    super.key,
    required this.theme,
    required this.creadoPor,
    this.fixedAsignadoA,
  });

  @override
  ConsumerState<CrearTareaPage> createState() => _CrearTareaPageState();
}

class _CrearTareaPageState extends ConsumerState<CrearTareaPage> {
  final _formKey = GlobalKey<FormState>();
  final _tituloCtrl = TextEditingController();
  final _descripcionCtrl = TextEditingController();
  final _reporteCtrl = TextEditingController();

  final Set<String> _selectedUserIds = <String>{};
  final Set<String> _selectedAsignadorIds = <String>{};

  final GlobalKey _asignadorFieldKey = GlobalKey();
  final GlobalKey _asignadosFieldKey = GlobalKey();

  bool _saving = false;

  void _refreshUsers() {
    final gerenciaId = ref
        .read(authControllerProvider)
        .user
        ?.resolvedGerenciaId;
    ref.invalidate(usersListByGerenciaProvider(gerenciaId));
  }

  RelativeRect _fieldMenuPosition(GlobalKey key) {
    final overlayBox =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final fieldBox = key.currentContext!.findRenderObject() as RenderBox;

    final fieldBottomLeft = fieldBox.localToGlobal(
      Offset(0, fieldBox.size.height),
      ancestor: overlayBox,
    );

    final left = fieldBottomLeft.dx;
    final top = fieldBottomLeft.dy;
    final right = overlayBox.size.width - left - fieldBox.size.width;
    final bottom = overlayBox.size.height - top;

    return RelativeRect.fromLTRB(left, top, right, bottom);
  }

  double _fieldWidth(GlobalKey key) {
    final fieldBox = key.currentContext!.findRenderObject() as RenderBox;
    return fieldBox.size.width;
  }

  Future<Set<String>?> _showAsignadoresMenu({
    required List<UserRef> users,
  }) async {
    if (_asignadorFieldKey.currentContext == null) return null;
    final pos = _fieldMenuPosition(_asignadorFieldKey);
    final width = _fieldWidth(_asignadorFieldKey);

    final selected = await showMenu<Set<String>>(
      context: context,
      position: pos,
      items: [
        _DropdownPanel<Set<String>>(
          width: width,
          height: 360,
          child: _AsignadoresDropdownBody(
            users: users,
            initialSelected: _selectedAsignadorIds,
            saving: _saving,
            onDone: (selected) => Navigator.of(context).pop(selected),
          ),
        ),
      ],
    );

    return selected;
  }

  Future<Set<String>?> _showAsignadosMenu({
    required List<UserRef> users,
  }) async {
    if (_asignadosFieldKey.currentContext == null) return null;
    final pos = _fieldMenuPosition(_asignadosFieldKey);
    final width = _fieldWidth(_asignadosFieldKey);

    final result = await showMenu<Set<String>>(
      context: context,
      position: pos,
      items: [
        _DropdownPanel<Set<String>>(
          width: width,
          height: 360,
          child: _AsignadosDropdownBody(
            users: users,
            initialSelected: _selectedUserIds,
            saving: _saving,
            onDone: (selected) => Navigator.of(context).pop(selected),
          ),
        ),
      ],
    );

    return result;
  }

  @override
  void initState() {
    super.initState();

    final creado = widget.creadoPor.trim();
    if (creado.isNotEmpty) {
      _selectedAsignadorIds.add(creado);
    }

    final fixed = widget.fixedAsignadoA;
    if (fixed != null && fixed.trim().isNotEmpty) {
      _selectedUserIds.add(fixed.trim());
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _refreshUsers();
    });
  }

  @override
  void dispose() {
    _tituloCtrl.dispose();
    _descripcionCtrl.dispose();
    _reporteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);
    final gerenciaId = auth.user?.resolvedGerenciaId;
    final canPickAsignador = auth.user?.isSupervisor ?? false;
    final asignadorLabel = auth.user?.nombre ?? widget.creadoPor;

    final isTablet = MediaQuery.of(context).size.width >= 600;
    final width = MediaQuery.of(context).size.width;
    final horizontalPadding = width >= 1200
        ? 120.0
        : width >= 900
        ? 80.0
        : width >= 600
        ? 60.0
        : 24.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.theme.colorPrimario,
        elevation: 4,
        shadowColor: widget.theme.colorPrimario.withAlpha(38),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Crear tarea',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(isTablet ? 24 : 20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: isTablet ? 32 : 24,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SectionContainer(
                title: 'Datos de la tarea',
                subtitle: 'Completa la información principal.',
                icon: Icons.task_alt,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _tituloCtrl,
                      decoration: const InputDecoration(labelText: 'Título'),
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Requerido' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _descripcionCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Descripción',
                      ),
                      minLines: 3,
                      maxLines: 6,
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Requerido' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _reporteCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Reporte ID (opcional)',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              SectionContainer(
                title: 'Asignación',
                subtitle: 'Define quién asigna y a quién se asigna.',
                icon: Icons.group_add,
                child: Column(
                  children: [
                    // Quién asigna / crea la tarea (puede ser distinto del usuario logueado).
                    if (!canPickAsignador) ...[
                      TextFormField(
                        initialValue: asignadorLabel,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Asignado por',
                        ),
                      ),
                      const SizedBox(height: 12),
                    ] else ...[
                      ref
                          .watch(usersListByGerenciaProvider(gerenciaId))
                          .when(
                            loading: () => InkWell(
                              onTap: _saving
                                  ? null
                                  : () {
                                      _refreshUsers();
                                    },
                              child: const InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Asignado por',
                                ),
                                child: Text('Cargando...'),
                              ),
                            ),
                            error: (e, _) => InkWell(
                              onTap: _saving
                                  ? null
                                  : () {
                                      _refreshUsers();
                                    },
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  labelText: 'Asignado por',
                                ),
                                child: Text(
                                  _usersLoadErrorMessage(e),
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                            data: (users) {
                              final byId = <String, String>{
                                for (final u in users) u.id: u.name,
                              };

                              String selectedSummary() {
                                final ids = _selectedAsignadorIds
                                    .where((e) => e.trim().isNotEmpty)
                                    .toList(growable: false);
                                if (ids.isEmpty) return 'Ninguno';
                                final names = ids
                                    .map((id) => byId[id] ?? id)
                                    .toList(growable: false);
                                names.sort(
                                  (a, b) => a.toLowerCase().compareTo(
                                    b.toLowerCase(),
                                  ),
                                );
                                if (names.length <= 2) return names.join(', ');
                                return '${names.take(2).join(', ')} +${names.length - 2}';
                              }

                              return InkWell(
                                key: _asignadorFieldKey,
                                onTap: _saving
                                    ? null
                                    : () async {
                                        _refreshUsers();
                                        final picked =
                                            await _showAsignadoresMenu(
                                              users: users,
                                            );
                                        if (!mounted || picked == null) return;
                                        setState(() {
                                          _selectedAsignadorIds
                                            ..clear()
                                            ..addAll(picked);
                                        });
                                      },
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    labelText: 'Asignado por',
                                    suffixIcon: Icon(Icons.arrow_drop_down),
                                  ),
                                  child: Text(
                                    'Seleccionados: ${_selectedAsignadorIds.length} • ${selectedSummary()}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              );
                            },
                          ),
                      const SizedBox(height: 12),
                    ],

                    if (widget.fixedAsignadoA == null) ...[
                      ref
                          .watch(usersListByGerenciaProvider(gerenciaId))
                          .when(
                            loading: () => const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: LinearProgressIndicator(),
                            ),
                            error: (e, _) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                _usersLoadErrorMessage(e),
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                            data: (users) {
                              String selectedSummary() {
                                if (_selectedUserIds.isEmpty) return 'Ninguno';
                                final byId = <String, String>{
                                  for (final u in users) u.id: u.name,
                                };
                                final names = _selectedUserIds
                                    .map((id) => byId[id] ?? id)
                                    .toList(growable: false);
                                names.sort(
                                  (a, b) => a.toLowerCase().compareTo(
                                    b.toLowerCase(),
                                  ),
                                );
                                if (names.length <= 2) return names.join(', ');
                                return '${names.take(2).join(', ')} +${names.length - 2}';
                              }

                              final subtitle =
                                  'Seleccionados: ${_selectedUserIds.length} • ${selectedSummary()}';

                              return InkWell(
                                key: _asignadosFieldKey,
                                onTap: _saving
                                    ? null
                                    : () async {
                                        _refreshUsers();
                                        final picked = await _showAsignadosMenu(
                                          users: users,
                                        );
                                        if (!mounted || picked == null) return;
                                        setState(() {
                                          _selectedUserIds
                                            ..clear()
                                            ..addAll(picked);
                                        });
                                      },
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    labelText: 'Asignar a',
                                    suffixIcon: Icon(Icons.arrow_drop_down),
                                  ),
                                  child: Text(
                                    subtitle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              );
                            },
                          ),
                      const SizedBox(height: 12),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _saving ? null : _onSave,
                  child: _saving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;

    final asignadores = <String>{..._selectedAsignadorIds.map((e) => e.trim())}
      ..removeWhere((e) => e.isEmpty);

    if (asignadores.isEmpty) {
      final fallback = widget.creadoPor.trim();
      if (fallback.isNotEmpty) asignadores.add(fallback);
    }

    final asignadorId = () {
      final ordered = asignadores.toList(growable: false)
        ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
      return ordered.isEmpty ? widget.creadoPor.trim() : ordered.first;
    }();

    final asignados = <String>{..._selectedUserIds}
      ..removeWhere((e) => e.trim().isEmpty);
    if (asignados.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona al menos un usuario.')),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      const uuid = Uuid();

      final batchId = uuid.v4();
      final createdAt = DateTime.now();
      final asignadoresGlpi = <String>{...asignadores}
        ..removeWhere((e) => e.isEmpty);

      for (final userId in asignados) {
        final tarea = Tarea(
          id: uuid.v4(),
          groupId: batchId,
          reporteId: _reporteCtrl.text.trim(),
          titulo: _tituloCtrl.text.trim(),
          descripcion: _descripcionCtrl.text.trim(),
          creadoPor: asignadorId,
          asignadoA: userId,
          estado: TareaEstado.pendiente,
        );

        await ref.read(tareaControllerProvider).crearTarea(tarea);
      }

      // GLPI (M:M): un solo ticket por creación, con lista de asignadores/asignados.
      final titulo = _tituloCtrl.text.trim();
      final descripcionBase = _descripcionCtrl.text.trim();
      final reporteId = _reporteCtrl.text.trim();

      final desc = StringBuffer()
        ..writeln(descripcionBase.isEmpty ? titulo : descripcionBase)
        ..writeln('')
        ..writeln('---')
        ..writeln('Origen: GTO Docs')
        ..writeln('BatchId: $batchId');

      if (reporteId.isNotEmpty) {
        desc.writeln('ReporteId: $reporteId');
      }

      final ticket = GlpiTicket(
        titulo: 'Tarea: $titulo',
        descripcion: desc.toString(),
        fecha: createdAt,
        asignadores: asignadoresGlpi.toList(growable: false),
        asignados: asignados.toList(growable: false),
        categoria: 'tareas',
        prioridad: 'media',
        users: [
          for (final a in asignadoresGlpi)
            GlpiTicketUser(userId: a, role: TicketUserRole.requester),
          for (final u in asignados)
            GlpiTicketUser(userId: u, role: TicketUserRole.assignee),
        ],
        metadata: {
          'source': 'gto_docs_v2_ad',
          'batchId': batchId,
          if (reporteId.isNotEmpty) 'reporteId': reporteId,
        },
      );

      await ref
          .read(glpiRepositoryProvider)
          .crearTicket(ticket, entidadId: batchId);

      if (mounted) {
        ref.invalidate(tareasPorAsignadoProvider);
        ref.invalidate(tareasPorCreadorProvider);
        ref.invalidate(todasLasTareasProvider);
        Navigator.of(context).pop(true);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  String _usersLoadErrorMessage(Object e) {
    if (e is StateError) {
      return e.message;
    }
    return 'No se pudieron cargar usuarios. ${e.toString()}';
  }
}

class _DropdownPanel<T> extends PopupMenuEntry<T> {
  final double _height;
  final double? _width;
  final Widget child;

  const _DropdownPanel({
    required double height,
    double? width,
    required this.child,
  }) : _height = height,
       _width = width;

  @override
  double get height => _height;

  @override
  bool represents(T? value) => false;

  @override
  State<_DropdownPanel<T>> createState() => _DropdownPanelState<T>();
}

class _DropdownPanelState<T> extends State<_DropdownPanel<T>> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: SizedBox(width: widget._width, child: widget.child),
    );
  }
}

class _AsignadoresDropdownBody extends StatefulWidget {
  final List<UserRef> users;
  final Set<String> initialSelected;
  final bool saving;
  final ValueChanged<Set<String>> onDone;

  const _AsignadoresDropdownBody({
    required this.users,
    required this.initialSelected,
    required this.saving,
    required this.onDone,
  });

  @override
  State<_AsignadoresDropdownBody> createState() =>
      _AsignadoresDropdownBodyState();
}

class _AsignadoresDropdownBodyState extends State<_AsignadoresDropdownBody> {
  late final Set<String> _selected = <String>{...widget.initialSelected}
    ..removeWhere((e) => e.trim().isEmpty);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Asignado por (${_selected.length})',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                TextButton(
                  onPressed: widget.saving
                      ? null
                      : () {
                          setState(() => _selected.clear());
                        },
                  child: const Text('Limpiar'),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 260),
            child: widget.users.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('No hay usuarios disponibles.'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.users.length,
                    itemBuilder: (context, i) {
                      final u = widget.users[i];
                      final checked = _selected.contains(u.id);
                      return CheckboxListTile(
                        dense: true,
                        value: checked,
                        title: Text(u.name),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: widget.saving
                            ? null
                            : (v) {
                                setState(() {
                                  if (v == true) {
                                    _selected.add(u.id);
                                  } else {
                                    _selected.remove(u.id);
                                  }
                                });
                              },
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.saving
                    ? null
                    : () => widget.onDone(_selected),
                child: const Text('Listo'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AsignadosDropdownBody extends StatefulWidget {
  final List<UserRef> users;
  final Set<String> initialSelected;
  final bool saving;
  final ValueChanged<Set<String>> onDone;

  const _AsignadosDropdownBody({
    required this.users,
    required this.initialSelected,
    required this.saving,
    required this.onDone,
  });

  @override
  State<_AsignadosDropdownBody> createState() => _AsignadosDropdownBodyState();
}

class _AsignadosDropdownBodyState extends State<_AsignadosDropdownBody> {
  late final Set<String> _selected = <String>{...widget.initialSelected};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Asignar a (${_selected.length})',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                TextButton(
                  onPressed: widget.saving
                      ? null
                      : () {
                          setState(() => _selected.clear());
                        },
                  child: const Text('Limpiar'),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 260),
            child: widget.users.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('No hay usuarios disponibles.'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.users.length,
                    itemBuilder: (context, i) {
                      final u = widget.users[i];
                      final checked = _selected.contains(u.id);
                      return CheckboxListTile(
                        dense: true,
                        value: checked,
                        title: Text(u.name),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: widget.saving
                            ? null
                            : (v) {
                                setState(() {
                                  if (v == true) {
                                    _selected.add(u.id);
                                  } else {
                                    _selected.remove(u.id);
                                  }
                                });
                              },
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.saving
                    ? null
                    : () => widget.onDone(_selected),
                child: const Text('Listo'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
