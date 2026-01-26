import 'dart:convert';
import 'package:drift/drift.dart';

class SyncQueueTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get entidad => text()();

  TextColumn get entidadId => text()(); 
  // Para GLPI usamos un UUID local o timestamp

  TextColumn get accion => text()(); // create, update, delete

  TextColumn get payload =>
      text().map(const SyncPayloadTypeConverter()).nullable()();

  BoolColumn get procesado =>
      boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}

class SyncPayloadTypeConverter
    extends TypeConverter<Map<String, dynamic>, String> {
  const SyncPayloadTypeConverter();

  @override
  Map<String, dynamic> fromSql(String fromDb) =>
      jsonDecode(fromDb) as Map<String, dynamic>;

  @override
  String toSql(Map<String, dynamic> value) =>
      jsonEncode(value);
}