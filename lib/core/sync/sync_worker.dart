import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../network/lan_status.dart';
import '../sync/sync_service.dart';
import '../../modules/notificacions/data/notificacion_repository_impl.dart';
import '../../modules/notificacions/domain/notificacion.dart';

class SyncWorker {
  final AppDatabase db;
  final SyncService service;
  final NotificacionRepository notificacionRepo;

  SyncWorker({
    required this.db,
    required this.service,
    required this.notificacionRepo,
  });

  Future<void> run(LanStatus lanStatus) async {
    if (lanStatus != LanStatus.connected) return;

    final pendientes =
        await (db.select(db.syncQueueTable)
              ..where((q) => q.procesado.equals(false))
              ..orderBy([(q) => OrderingTerm.asc(q.createdAt)]))
            .get();

    for (final item in pendientes) {
      try {
        // ignore: avoid_print
        print(
          '[SYNC] Procesando ${item.entidad}:${item.accion} id=${item.entidadId}',
        );
        // ASISTENCIA
        if (item.entidad == 'asistencia' && item.accion == 'create') {
          await service.syncAsistencia(int.parse(item.entidadId));
        }

        // GLPI TICKET
        if (item.entidad == 'glpi_ticket' &&
            item.accion == 'create' &&
            item.payload != null) {
          await service.syncGlpiTicket(item.payload!);
        }

        // REPORTE
        if (item.entidad == 'reporte' &&
            item.accion == 'create' &&
            item.payload != null) {
          await service.syncReporte(item.payload!);
        }

        // COMENTARIO DE REPORTE
        if (item.entidad == 'reporte_comentario' &&
            item.accion == 'create' &&
            item.payload != null) {
          await service.syncReporteComentario(item.payload!);
        }

        // EVIDENCIA
        if (item.entidad == 'reporte_evidencia' &&
            item.accion == 'upload' &&
            item.payload != null) {
          await service.syncReporteEvidencia(item.payload!);
        }

        // TAREA
        if (item.entidad == 'tarea' &&
            item.accion == 'create' &&
            item.payload != null) {
          final remote = await service.syncTarea(item.payload!);
          final remoteId = remote?['id']?.toString();
          if (remoteId != null && remoteId.isNotEmpty) {
            final updated =
                await (db.update(db.tareasTable)
                      ..where((t) => t.id.equals(item.entidadId)))
                    .write(TareasTableCompanion(remoteId: Value(remoteId)));

            if (updated == 0) {
              // ignore: avoid_print
              print(
                '[SYNC] WARN tarea:create no existe local id=${item.entidadId} para guardar remoteId=$remoteId',
              );
            }
          }
        }

        // CAMBIO DE ESTADO DE TAREA
        if (item.entidad == 'tarea' &&
            item.accion == 'update_estado' &&
            item.payload != null) {
          await service.syncTareaEstado(item.payload!);
        }

        // COMENTARIO DE TAREA
        if (item.entidad == 'tarea_comentario' &&
            item.accion == 'create' &&
            item.payload != null) {
          await service.syncTareaComentario(item.payload!);
        }

        // ADJUNTO DE TAREA
        if (item.entidad == 'tarea_adjunto' &&
            item.accion == 'upload' &&
            item.payload != null) {
          await service.syncTareaAdjunto(item.payload!);
        }

        // CAMBIO DE ESTADO DE REPORTE (backend → app)
        if (item.entidad == 'reporte_estado' && item.payload != null) {
          // aquí también podrías actualizar el reporte local

          await notificacionRepo.crear(
            tipo: NotificacionTipo.reporte.name,
            titulo: 'Reporte resuelto',
            mensaje: 'Tu reporte fue marcado como resuelto',
            referenciaId: item.entidadId,
          );
        }

        // NOTIFICACIÓN REMOTA
        if (item.entidad == 'notificacion' && item.payload != null) {
          await notificacionRepo.crear(
            tipo: NotificacionTipo.sistema.name,
            titulo: item.payload!['titulo'] as String,
            mensaje: item.payload!['mensaje'] as String,
            referenciaId: item.entidadId,
          );
        }

        // RESULTADO IA
        if (item.entidad == 'ia_resultado' && item.payload != null) {
          // aquí luego podrás actualizar prioridad, responsables, etc.

          await notificacionRepo.crear(
            tipo: NotificacionTipo.sistema.name,
            titulo: 'Clasificación automática',
            mensaje: 'IA asignó prioridad y responsables',
            referenciaId: item.entidadId,
          );
        }

        // ✅ MARCAR COMO PROCESADO
        await (db.update(db.syncQueueTable)..where((q) => q.id.equals(item.id)))
            .write(const SyncQueueTableCompanion(procesado: Value(true)));

        // ignore: avoid_print
        print('[SYNC] OK ${item.entidad}:${item.accion} id=${item.entidadId}');
      } catch (e) {
        // ignore: avoid_print
        print(
          '[SYNC] ERROR ${item.entidad}:${item.accion} id=${item.entidadId} -> $e',
        );
        // GLPI no debe bloquear el resto de sincronización.
        // Se reintentará en la siguiente corrida (queda como no-procesado).
        if (item.entidad == 'glpi_ticket') {
          continue;
        }

        // Para el resto, si falla uno se detiene y se reintentará después.
        break;
      }
    }
  }
}
