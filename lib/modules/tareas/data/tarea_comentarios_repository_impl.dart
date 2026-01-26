import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../domain/tarea_comentario.dart';

class TareaComentariosRepository {
  final AppDatabase db;

  TareaComentariosRepository(this.db);

  Future<void> agregarComentario({
    required String tareaId,
    required String autorId,
    required String mensaje,
  }) async {
    final c = TareaComentario(
      id: const Uuid().v4(),
      tareaId: tareaId,
      autorId: autorId,
      mensaje: mensaje,
      creadoEn: DateTime.now(),
    );

    await db
        .into(db.tareaComentariosTable)
        .insert(
          TareaComentariosTableCompanion.insert(
            id: c.id,
            tareaId: c.tareaId,
            autorId: c.autorId,
            mensaje: c.mensaje,
            creadoEn: c.creadoEn,
          ),
        );

    await db
        .into(db.syncQueueTable)
        .insert(
          SyncQueueTableCompanion.insert(
            entidad: 'tarea_comentario',
            entidadId: c.id,
            accion: 'create',
            payload: Value({
              'id': c.id,
              'tareaId': c.tareaId,
              'usuarioId': c.autorId,
              'mensaje': c.mensaje,
            }),
          ),
        );
  }

  Stream<List<TareaComentario>> watchPorTareaId(String tareaId) {
    return (db.select(db.tareaComentariosTable)
          ..where((c) => c.tareaId.equals(tareaId))
          ..orderBy([(c) => OrderingTerm.asc(c.creadoEn)]))
        .watch()
        .map(
          (rows) => rows
              .map(
                (r) => TareaComentario(
                  id: r.id,
                  tareaId: r.tareaId,
                  autorId: r.autorId,
                  mensaje: r.mensaje,
                  creadoEn: r.creadoEn,
                ),
              )
              .toList(growable: false),
        );
  }
}
