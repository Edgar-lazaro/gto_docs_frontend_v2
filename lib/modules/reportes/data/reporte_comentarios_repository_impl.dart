import 'package:drift/drift.dart';

import 'package:gto_docs_v2_ad/core/database/app_database.dart';
import 'package:gto_docs_v2_ad/modules/reportes/domain/reporte_comentario.dart';

class ReporteComentariosRepository {
  final AppDatabase db;

  ReporteComentariosRepository(this.db);

  Future<void> agregarComentario(ReporteComentario c) async {
    await db
        .into(db.reporteComentariosTable)
        .insert(
          ReporteComentariosTableCompanion.insert(
            id: c.id,
            reporteId: c.reporteId,
            autorId: c.autorId,
            mensaje: c.mensaje,
            creadoEn: c.creadoEn,
          ),
        );

    await db
        .into(db.syncQueueTable)
        .insert(
          SyncQueueTableCompanion.insert(
            entidad: 'reporte_comentario',
            entidadId: c.id,
            accion: 'create',
            payload: Value({
              'id': c.id,
              'reporteId': c.reporteId,
              'usuarioId': c.autorId,
              'mensaje': c.mensaje,
            }),
          ),
        );
  }
}
