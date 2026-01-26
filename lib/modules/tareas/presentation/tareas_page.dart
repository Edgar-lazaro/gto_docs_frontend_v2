import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/role_utils.dart';
import '../../../core/auth/auth_providers.dart';
import '../../../core/auth/auth_models.dart';
import '../../../shared/ui/theme/gerencia_config.dart';
import '../../../shared/ui/widgets/gerencia_app_bar.dart';
import 'admin_tareas_page.dart';
import 'crear_tarea_page.dart';
import 'tarea_detalle_page.dart';
import 'tarea_grupo_detalle_page.dart';
import 'tareas_providers.dart';
import '../domain/tarea.dart';

class TareasPage extends ConsumerWidget {
  final GerenciaTheme theme;

  const TareasPage({super.key, required this.theme});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    final isSupervisor = user.isSupervisor;

    if (isSupervisor) {
      return AdminTareasPage(theme: theme);
    }

    final tareasAsync = ref.watch(tareasPorAsignadoProvider(user.id));

    return Scaffold(
      appBar: GerenciaAppBar(
        theme: theme,
        title: 'Tareas',
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(tareasPorAsignadoProvider(user.id)),
            tooltip: 'Actualizar',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final created = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (_) => CrearTareaPage(
                theme: theme,
                creadoPor: user.id,
                fixedAsignadoA: user.id,
              ),
            ),
          );

          if (created == true) {
            ref.invalidate(tareasPorAsignadoProvider(user.id));
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Añadir'),
      ),
      body: tareasAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('No hay tareas'));
          }

          return ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isTablet ? 32 : 24,
            ),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (_, i) {
              final t = items[i];
              return _TareaCard(
                tarea: t,
                onTap: () {
                  final gid =
                      (t.groupId != null && t.groupId!.trim().isNotEmpty)
                      ? t.groupId!.trim()
                      : null;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => gid == null
                          ? TareaDetallePage(theme: theme, tarea: t)
                          : TareaGrupoDetallePage(
                              theme: theme,
                              groupId: gid,
                              fallback: t,
                            ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _TareaCard extends StatelessWidget {
  final Tarea tarea;
  final VoidCallback onTap;

  const _TareaCard({required this.tarea, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Card(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
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
                    Icons.task_alt,
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
                        tarea.titulo,
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
                        'Estado: ${tarea.estado.name}',
                        style: TextStyle(
                          fontSize: isTablet ? 14 : 12,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
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
