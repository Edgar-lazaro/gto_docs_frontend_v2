import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/tarea.dart';
import '../domain/tarea_repository.dart';

class TareaRepositoryImpl implements TareaRepository {
  final AppDatabase db;

  TareaRepositoryImpl(this.db);

  @override
  Future<void> crearTarea(Tarea tarea) async {
    await db
        .into(db.tareasTable)
        .insert(
          TareasTableCompanion.insert(
            id: tarea.id,
            groupId: Value(tarea.groupId),
            reporteId: tarea.reporteId,
            titulo: tarea.titulo,
            descripcion: Value(tarea.descripcion),
            creadoPor: Value(tarea.creadoPor),
            asignadoA: tarea.asignadoA,
            estado: tarea.estado.name,
          ),
        );

    await db
        .into(db.syncQueueTable)
        .insert(
          SyncQueueTableCompanion.insert(
            entidad: 'tarea',
            entidadId: tarea.id,
            accion: 'create',
            payload: Value({
              'id': tarea.id,
              if (tarea.groupId != null && tarea.groupId!.trim().isNotEmpty)
                'groupId': tarea.groupId,
              'titulo': tarea.titulo,
              // Compat (app)
              'reporteId': tarea.reporteId,
              'creadoPor': tarea.creadoPor,
              'asignadoA': tarea.asignadoA,
              // Requeridos (backend Prisma)
              'descripcion': tarea.descripcion,
              'creadorId': tarea.creadoPor,
              'estado': tarea.estado.name,
            }),
          ),
        );
  }

  @override
  Future<void> actualizarEstado({
    required String tareaId,
    required TareaEstado estado,
  }) async {
    await (db.update(db.tareasTable)..where((t) => t.id.equals(tareaId))).write(
      TareasTableCompanion(estado: Value(estado.name)),
    );

    await db
        .into(db.syncQueueTable)
        .insert(
          SyncQueueTableCompanion.insert(
            entidad: 'tarea',
            entidadId: tareaId,
            accion: 'update_estado',
            payload: Value({'id': tareaId, 'estado': estado.name}),
          ),
        );
  }

  @override
  Future<List<Tarea>> obtenerPorAsignado(String asignadoA) async {
    final rows =
        await (db.select(db.tareasTable)
              ..where((t) => t.asignadoA.equals(asignadoA))
              ..orderBy([(t) => OrderingTerm.desc(t.titulo)]))
            .get();

    return rows
        .map(
          (t) => Tarea(
            id: t.id,
            groupId: t.groupId,
            reporteId: t.reporteId,
            titulo: t.titulo,
            descripcion: t.descripcion,
            creadoPor: t.creadoPor,
            asignadoA: t.asignadoA,
            estado: TareaEstado.values.byName(t.estado),
          ),
        )
        .toList();
  }

  @override
  Future<List<Tarea>> obtenerPorCreador(String creadoPor) async {
    final rows =
        await (db.select(db.tareasTable)
              ..where((t) => t.creadoPor.equals(creadoPor))
              ..orderBy([(t) => OrderingTerm.desc(t.titulo)]))
            .get();

    return rows
        .map(
          (t) => Tarea(
            id: t.id,
            groupId: t.groupId,
            reporteId: t.reporteId,
            titulo: t.titulo,
            descripcion: t.descripcion,
            creadoPor: t.creadoPor,
            asignadoA: t.asignadoA,
            estado: TareaEstado.values.byName(t.estado),
          ),
        )
        .toList();
  }

  @override
  Future<List<Tarea>> obtenerTodas() async {
    final rows = await (db.select(
      db.tareasTable,
    )..orderBy([(t) => OrderingTerm.desc(t.titulo)])).get();

    return rows
        .map(
          (t) => Tarea(
            id: t.id,
            groupId: t.groupId,
            reporteId: t.reporteId,
            titulo: t.titulo,
            descripcion: t.descripcion,
            creadoPor: t.creadoPor,
            asignadoA: t.asignadoA,
            estado: TareaEstado.values.byName(t.estado),
          ),
        )
        .toList();
  }
}
