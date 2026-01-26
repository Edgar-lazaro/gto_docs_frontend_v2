import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../notificacions/domain/notificacion.dart';
import '../../reportes/presentation/reporte_detalle_page.dart';
import 'notificacion_providers.dart';

class NotificacionesPage extends ConsumerWidget {
  const NotificacionesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(notificacionesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: 'Marcar todas como leídas',
            onPressed: () async {
              await ref
                  .read(notificacionRepositoryProvider)
                  .marcarTodasLeidas();
            },
          ),
        ],
      ),
      body: data.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text('No hay notificaciones'),
            );
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, i) {
              final n = items[i];

              return ListTile(
                title: Text(n.titulo),
                subtitle: Text(n.mensaje),
                trailing: n.leida
                    ? null
                    : const Icon(Icons.circle, size: 10),
                onTap: () async {
                  // marcar como leída
                  await ref
                      .read(notificacionRepositoryProvider)
                      .marcarLeida(n.id);

                  if (!context.mounted) return;

                  // navegar según tipo
                  if (n.tipo == NotificacionTipo.reporte &&
                      n.referenciaId != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReporteDetallePage(
                          reporteId: n.referenciaId!,
                        ),
                      ),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}