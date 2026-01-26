import 'package:drift/drift.dart';

class ReportesTable extends Table {
  TextColumn get id => text()();

  TextColumn get titulo => text()();
  TextColumn get descripcion => text()();
  TextColumn get categoria => text()();
  TextColumn get area => text()();

  TextColumn get activo => text().nullable()();
  TextColumn get ubicacion => text().nullable()();

  TextColumn get creadoPor => text()();
  DateTimeColumn get creadoEn => dateTime()();

  TextColumn get estado => text()();

  TextColumn get glpiTicketId => text().nullable()();

  TextColumn get metadata => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}