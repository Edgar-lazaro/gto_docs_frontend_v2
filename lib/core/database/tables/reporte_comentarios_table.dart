import 'package:drift/drift.dart';

class ReporteComentariosTable extends Table {
  TextColumn get id => text()();
  TextColumn get reporteId => text()();
  TextColumn get autorId => text()();
  TextColumn get mensaje => text()();
  DateTimeColumn get creadoEn => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}