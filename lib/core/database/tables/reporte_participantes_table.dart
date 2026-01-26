import 'package:drift/drift.dart';

class ReporteParticipantesTable extends Table {
  TextColumn get reporteId => text()();
  TextColumn get userId => text()();
  TextColumn get rol => text()();

  @override
  Set<Column> get primaryKey => {reporteId, userId};
}