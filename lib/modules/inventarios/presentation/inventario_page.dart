import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_models.dart';
import '../../../core/auth/auth_providers.dart';
import '../../../core/auth/role_utils.dart';
import '../../../shared/ui/theme/gerencia_config.dart';
import '../../../shared/ui/widgets/gerencia_app_bar.dart';
import '../domain/activo.dart';
import 'inventario_providers.dart';

class InventarioPage extends ConsumerStatefulWidget {
  final GerenciaTheme theme;

  const InventarioPage({super.key, required this.theme});

  @override
  ConsumerState<InventarioPage> createState() => _InventarioPageState();
}

class _InventarioPageState extends ConsumerState<InventarioPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final width = MediaQuery.of(context).size.width;
    final horizontalPadding = width >= 1200
        ? 120.0
        : width >= 900
        ? 80.0
        : width >= 600
        ? 60.0
        : 24.0;

    final auth = ref.watch(authControllerProvider);
    if (auth.status != AuthStatus.authenticated || auth.user == null) {
      return const Scaffold(body: Center(child: Text('Debes iniciar sesión')));
    }

    final user = auth.user!;
    final canCrud = user.isSupervisor && !user.isAuxiliar;

    final inventarioAsync = ref.watch(inventarioItemsProvider);

    return Scaffold(
      appBar: GerenciaAppBar(theme: widget.theme, title: 'Inventario'),
      floatingActionButton: canCrud
          ? FloatingActionButton.extended(
              onPressed: () => _openCreateDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Agregar'),
            )
          : null,
      body: inventarioAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 32 : 24),
            child: Text('Error al cargar inventario: $e'),
          ),
        ),
        data: (items) {
          final filtered = _applySearch(items);

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(inventarioItemsProvider);
              await ref.read(inventarioItemsProvider.future);
            },
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isTablet ? 32 : 24,
              ),
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _searchQuery = v),
                  decoration: InputDecoration(
                    hintText: 'Buscar en inventario…',
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
                SizedBox(height: isTablet ? 24 : 16),
                if (items.isEmpty)
                  const Center(child: Text('No hay registros de inventario')),
                ...filtered.map(
                  (a) => _ActivoCard(
                    activo: a,
                    canCrud: canCrud,
                    onEdit: () => _openEditDialog(context, a),
                    onDelete: () => _confirmDelete(context, a),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _openCreateDialog(BuildContext context) async {
    final created = await showDialog<Activo>(
      context: context,
      builder: (_) => _ActivoDialog(theme: widget.theme),
    );
    if (created == null) return;

    try {
      await ref.read(inventarioRepositoryProvider).crearActivo(created);
      ref.invalidate(inventarioItemsProvider);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('No se pudo crear: $e')));
    }
  }

  Future<void> _openEditDialog(BuildContext context, Activo activo) async {
    final updated = await showDialog<Activo>(
      context: context,
      builder: (_) => _ActivoDialog(theme: widget.theme, initial: activo),
    );
    if (updated == null) return;

    try {
      await ref.read(inventarioRepositoryProvider).actualizarActivo(updated);
      ref.invalidate(inventarioItemsProvider);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('No se pudo actualizar: $e')));
    }
  }

  Future<void> _confirmDelete(BuildContext context, Activo activo) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar'),
        content: Text('¿Eliminar "${activo.nombre}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (ok != true) return;

    try {
      await ref.read(inventarioRepositoryProvider).eliminarActivo(activo.id);
      ref.invalidate(inventarioItemsProvider);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('No se pudo eliminar: $e')));
    }
  }

  List<Activo> _applySearch(List<Activo> items) {
    final q = _searchQuery.trim().toLowerCase();
    if (q.isEmpty) return items;
    return items.where((a) {
      final hay = '${a.nombre} ${a.tipo} ${a.ubicacion} ${a.estado}'
          .toLowerCase();
      return hay.contains(q);
    }).toList();
  }
}

class _ActivoCard extends StatelessWidget {
  final Activo activo;

  final bool canCrud;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const _ActivoCard({
    required this.activo,
    required this.canCrud,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Container(
      margin: EdgeInsets.only(bottom: isTablet ? 20 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isTablet ? 20 : 16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: isTablet ? 15 : 12,
            offset: Offset(0, isTablet ? 6 : 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 20 : 16),
        child: Row(
          children: [
            Container(
              width: isTablet ? 64 : 56,
              height: isTablet ? 64 : 56,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
              ),
              child: Icon(
                Icons.inventory_2,
                color: Colors.blue[700],
                size: isTablet ? 34 : 30,
              ),
            ),
            SizedBox(width: isTablet ? 20 : 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activo.nombre,
                    style: TextStyle(
                      fontSize: isTablet ? 18 : 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 10,
                    runSpacing: 6,
                    children: [
                      if (activo.tipo.isNotEmpty)
                        _Chip(text: activo.tipo, icon: Icons.category),
                      if (activo.ubicacion.isNotEmpty)
                        _Chip(text: activo.ubicacion, icon: Icons.place),
                      if (activo.estado.isNotEmpty)
                        _Chip(text: activo.estado, icon: Icons.info_outline),
                      _Chip(
                        text: 'Cant: ${activo.cantidad}',
                        icon: Icons.numbers,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (canCrud)
              PopupMenuButton<String>(
                onSelected: (v) {
                  if (v == 'edit') onEdit?.call();
                  if (v == 'delete') onDelete?.call();
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'edit', child: Text('Editar')),
                  PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ActivoDialog extends StatefulWidget {
  final GerenciaTheme theme;
  final Activo? initial;

  const _ActivoDialog({required this.theme, this.initial});

  @override
  State<_ActivoDialog> createState() => _ActivoDialogState();
}

class _ActivoDialogState extends State<_ActivoDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombre;
  late final TextEditingController _tipo;
  late final TextEditingController _ubicacion;
  late final TextEditingController _estado;
  late final TextEditingController _cantidad;
  late final TextEditingController _descripcion;

  @override
  void initState() {
    super.initState();
    final a = widget.initial;
    _nombre = TextEditingController(text: a?.nombre ?? '');
    _tipo = TextEditingController(text: a?.tipo ?? '');
    _ubicacion = TextEditingController(text: a?.ubicacion ?? '');
    _estado = TextEditingController(text: a?.estado ?? '');
    _cantidad = TextEditingController(text: (a?.cantidad ?? 0).toString());
    _descripcion = TextEditingController(text: a?.descripcion ?? '');
  }

  @override
  void dispose() {
    _nombre.dispose();
    _tipo.dispose();
    _ubicacion.dispose();
    _estado.dispose();
    _cantidad.dispose();
    _descripcion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: widget.theme.colorPrimario.withAlpha(22),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              widget.initial == null ? Icons.add : Icons.edit,
              color: widget.theme.colorPrimario,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.initial == null ? 'Agregar activo' : 'Editar activo',
                ),
                const SizedBox(height: 2),
                Text(
                  'Completa los datos del inventario.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 14, 24, 10),
      content: SizedBox(
        width: 520,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nombre,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Requerido' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _tipo,
                  decoration: const InputDecoration(
                    labelText: 'Tipo/Categoría',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _ubicacion,
                  decoration: const InputDecoration(labelText: 'Ubicación'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _estado,
                  decoration: const InputDecoration(labelText: 'Estado'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _cantidad,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Cantidad'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descripcion,
                  decoration: const InputDecoration(labelText: 'Descripción'),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(onPressed: _onSave, child: const Text('Guardar')),
      ],
    );
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;
    final id =
        widget.initial?.id ?? DateTime.now().millisecondsSinceEpoch.toString();
    final cant = int.tryParse(_cantidad.text.trim()) ?? 0;
    Navigator.pop(
      context,
      Activo(
        id: id,
        nombre: _nombre.text.trim(),
        tipo: _tipo.text.trim(),
        ubicacion: _ubicacion.text.trim(),
        estado: _estado.text.trim(),
        cantidad: cant,
        descripcion: _descripcion.text.trim().isEmpty
            ? null
            : _descripcion.text.trim(),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  final IconData icon;

  const _Chip({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey[700]),
          const SizedBox(width: 6),
          Text(text, style: TextStyle(fontSize: 14, color: Colors.grey[800])),
        ],
      ),
    );
  }
}
