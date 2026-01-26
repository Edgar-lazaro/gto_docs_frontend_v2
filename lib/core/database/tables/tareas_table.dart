import 'package:drift/drift.dart';

class TareasTable extends Table {
  TextColumn get id => text()();
  // ID que devuelve el backend 
  TextColumn get remoteId => text().nullable()();
  // Agrupador M:M: 
  TextColumn get groupId => text().nullable()();
  TextColumn get reporteId => text()();
  TextColumn get titulo => text()();
  TextColumn get descripcion => text().withDefault(const Constant(''))();
  TextColumn get creadoPor => text().nullable()();
  TextColumn get asignadoA => text()();
  TextColumn get estado => text()();

  @override
  Set<Column> get primaryKey => {id};
}
