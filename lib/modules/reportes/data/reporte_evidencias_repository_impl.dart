import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../domain/reporte_evidencia.dart';

class ReporteEvidenciasRepository {
  final AppDatabase db;

  ReporteEvidenciasRepository(this.db);

  Future<void> agregarEvidencia({
    required String reporteId,
    required EvidenciaTipo tipo,
    required String nombre,
    required String localPath,
  }) async {
    final evidencia = ReporteEvidencia(
      id: const Uuid().v4(),
      reporteId: reporteId,
      tipo: tipo,
      nombre: nombre,
      localPath: localPath,
      creadoEn: DateTime.now(),
    );

    // Guardar evidencia local
    await db
        .into(db.reporteEvidenciasTable)
        .insert(
          ReporteEvidenciasTableCompanion.insert(
            id: evidencia.id,
            reporteId: evidencia.reporteId,
            tipo: evidencia.tipo.name,
            nombre: evidencia.nombre,
            localPath: evidencia.localPath,
            creadoEn: evidencia.creadoEn,
          ),
        );

    // Encolar evento de sync (upload)
    await db
        .into(db.syncQueueTable)
        .insert(
          SyncQueueTableCompanion.insert(
            entidad: 'reporte_evidencia',
            entidadId: evidencia.id,
            accion: 'upload',
            payload: Value({
              'id': evidencia.id,
              'reporteId': evidencia.reporteId,
              'localPath': evidencia.localPath,
              'tipo': evidencia.tipo.name,
              'nombre': evidencia.nombre,
            }),
          ),
        );
  }
}
