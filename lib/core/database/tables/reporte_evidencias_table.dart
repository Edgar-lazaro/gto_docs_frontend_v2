import 'package:drift/drift.dart';

class ReporteEvidenciasTable extends Table {
  TextColumn get id => text()();
  TextColumn get reporteId => text()();
  TextColumn get tipo => text()();
  TextColumn get nombre => text()();
  TextColumn get localPath => text()();
  TextColumn get remoteUrl => text().nullable()();
  DateTimeColumn get creadoEn => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}