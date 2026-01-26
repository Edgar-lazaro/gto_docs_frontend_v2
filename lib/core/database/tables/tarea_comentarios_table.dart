import 'package:drift/drift.dart';

class TareaComentariosTable extends Table {
  TextColumn get id => text()();
  TextColumn get tareaId => text()();
  TextColumn get autorId => text()();
  TextColumn get mensaje => text()();
  DateTimeColumn get creadoEn => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
