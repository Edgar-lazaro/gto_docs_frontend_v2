import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_models.dart';
import '../../../core/auth/auth_providers.dart';
import '../../../core/auth/role_utils.dart';
import '../../../core/users/users_providers.dart';
import '../../../shared/ui/theme/gerencia_config.dart';
import '../../../shared/ui/widgets/gerencia_app_bar.dart';
import '../domain/tarea.dart';
import 'crear_tarea_page.dart';
import 'tarea_grupo_detalle_page.dart';
import 'tareas_providers.dart';

class AdminTareasPage extends ConsumerStatefulWidget {
  final GerenciaTheme theme;

  const AdminTareasPage({super.key, required this.theme});

  @override
  ConsumerState<AdminTareasPage> createState() => _AdminTareasPageState();
}

class _AdminTareasPageState extends ConsumerState<AdminTareasPage> {
  int _selectedScope = 0; // 0=Mis(creadas), 1=Asignadas(a mí), 2=Todas

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

    final userId = auth.user!.id;
    final gerenciaId = auth.user!.resolvedGerenciaId;
    final tareasAsync = switch (_selectedScope) {
      0 => ref.watch(tareasPorCreadorProvider(userId)),
      1 => ref.watch(tareasPorAsignadoProvider(userId)),
      _ => ref.watch(todasLasTareasProvider),
    };

    final usersAsync = ref.watch(usersListByGerenciaProvider(gerenciaId));

    return Scaffold(
      appBar: GerenciaAppBar(
        theme: widget.theme,
        title: 'Tareas',
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (_selectedScope == 0) {
                ref.invalidate(tareasPorCreadorProvider(userId));
              }
              if (_selectedScope == 1) {
                ref.invalidate(tareasPorAsignadoProvider(userId));
              }
              if (_selectedScope == 2) {
                ref.invalidate(todasLasTareasProvider);
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final created = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  CrearTareaPage(theme: widget.theme, creadoPor: auth.user!.id),
            ),
          );

          if (created == true) {
            ref.invalidate(tareasPorCreadorProvider(userId));
            ref.invalidate(tareasPorAsignadoProvider(userId));
            ref.invalidate(todasLasTareasProvider);
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Crear'),
      ),
      body: tareasAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (items) {
          final grouped = <String, List<Tarea>>{};
          for (final t in items) {
            final gid = (t.groupId != null && t.groupId!.trim().isNotEmpty)
                ? t.groupId!.trim()
                : t.id;
            (grouped[gid] ??= <Tarea>[]).add(t);
          }

          final groups = grouped.entries.toList(growable: false)
            ..sort((a, b) {
              final at = a.value.isNotEmpty ? a.value.first.titulo : '';
              final bt = b.value.isNotEmpty ? b.value.first.titulo : '';
              return at.toLowerCase().compareTo(bt.toLowerCase());
            });

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  16,
                  horizontalPadding,
                  8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SegmentedButton<int>(
                        segments: const [
                          ButtonSegment(value: 0, label: Text('Mis')),
                          ButtonSegment(value: 1, label: Text('Asignadas')),
                          ButtonSegment(value: 2, label: Text('Todas')),
                        ],
                        selected: <int>{_selectedScope},
                        onSelectionChanged: (s) {
                          setState(() => _selectedScope = s.first);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: groups.isEmpty
                    ? const Center(child: Text('No hay tareas'))
                    : ListView.separated(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          8,
                          horizontalPadding,
                          isTablet ? 32 : 24,
                        ),
                        itemCount: groups.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (_, i) {
                          final entry = groups[i];
                          return usersAsync.when(
                            loading: () => _TareaGroupTile(
                              groupId: entry.key,
                              tareas: entry.value,
                              theme: widget.theme,
                              nameForUserId: (id) => id,
                            ),
                            error: (error, stackTrace) => _TareaGroupTile(
                              groupId: entry.key,
                              tareas: entry.value,
                              theme: widget.theme,
                              nameForUserId: (id) => id,
                            ),
                            data: (users) {
                              final byId = <String, String>{
                                for (final u in users) u.id: u.name,
                              };
                              return _TareaGroupTile(
                                groupId: entry.key,
                                tareas: entry.value,
                                theme: widget.theme,
                                nameForUserId: (id) => byId[id] ?? id,
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TareaGroupTile extends StatelessWidget {
  final String groupId;
  final List<Tarea> tareas;
  final GerenciaTheme theme;
  final String Function(String userId) nameForUserId;

  const _TareaGroupTile({
    required this.groupId,
    required this.tareas,
    required this.theme,
    required this.nameForUserId,
  });

  TareaEstado _aggregateEstado() {
    if (tareas.any((t) => t.estado == TareaEstado.pendiente)) {
      return TareaEstado.pendiente;
    }
    if (tareas.any((t) => t.estado == TareaEstado.enProceso)) {
      return TareaEstado.enProceso;
    }
    return TareaEstado.completada;
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final head = tareas.isNotEmpty ? tareas.first : null;
    final estado = _aggregateEstado();

    String estadoLabel() => switch (estado) {
      TareaEstado.pendiente => 'Pendiente',
      TareaEstado.enProceso => 'En proceso',
      TareaEstado.completada => 'Completada',
    };

    final assignees = tareas.map((t) => nameForUserId(t.asignadoA)).toList();
    assignees.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    String assigneesSummary() {
      if (assignees.isEmpty) return 'Sin asignados';
      if (assignees.length <= 2) return assignees.join(', ');
      return '${assignees.take(2).join(', ')} +${assignees.length - 2}';
    }

    return Container(
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (head == null) return;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TareaGrupoDetallePage(
                  theme: theme,
                  groupId: groupId,
                  fallback: head,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(isTablet ? 20 : 16),
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 20 : 16),
            child: Row(
              children: [
                Container(
                  width: isTablet ? 56 : 48,
                  height: isTablet ? 56 : 48,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                  ),
                  child: Icon(
                    Icons.assignment,
                    color: Colors.blue[700],
                    size: isTablet ? 30 : 26,
                  ),
                ),
                SizedBox(width: isTablet ? 20 : 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        head?.titulo ?? 'Tarea',
                        style: TextStyle(
                          fontSize: isTablet ? 18 : 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Asignados: ${tareas.length} • ${assigneesSummary()}',
                        style: TextStyle(
                          fontSize: isTablet ? 14 : 12,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Estado: ${estadoLabel()}',
                        style: TextStyle(
                          fontSize: isTablet ? 13 : 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: isTablet ? 24 : 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
