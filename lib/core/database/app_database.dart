import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/asistencia_table.dart';
import 'tables/notifications_table.dart';
import 'tables/sync_queue_table.dart';
import 'tables/tareas_table.dart';
import 'tables/reporte_comentarios_table.dart';
import 'tables/reporte_evidencias_table.dart';
import 'tables/reporte_participantes_table.dart';
import 'tables/reportes_table.dart';
import 'tables/tarea_comentarios_table.dart';
import 'tables/tarea_adjuntos_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    AsistenciaTable,
    NotificationsTable,
    SyncQueueTable,
    TareasTable,
    TareaComentariosTable,
    TareaAdjuntosTable,
    ReportesTable,
    ReporteComentariosTable,
    ReporteEvidenciasTable,
    ReporteParticipantesTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Versión 1: esquema inicial
  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.addColumn(tareasTable, tareasTable.creadoPor);
      }
      if (from < 3) {
        await m.addColumn(tareasTable, tareasTable.descripcion);
      }
      if (from < 4) {
        await m.addColumn(tareasTable, tareasTable.remoteId);
      }
      if (from < 5) {
        await m.addColumn(tareasTable, tareasTable.groupId);
      }
      if (from < 6) {
        await m.createTable(tareaComentariosTable);
        await m.createTable(tareaAdjuntosTable);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'gto_docs.db'));
    return NativeDatabase(file);
  });
}
