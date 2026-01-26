import 'package:drift/drift.dart';

class NotificationsTable extends Table {
  TextColumn get id => text()();
  TextColumn get titulo => text()();
  TextColumn get mensaje => text()();
  TextColumn get tipo =>
      text().withDefault(const Constant('info'))(); // info | alerta | critica
  BoolColumn get leida =>
      boolean().withDefault(const Constant(false))();
  TextColumn get origen =>
      text().nullable()(); // asistencia, glpi, inventarios
  DateTimeColumn get fecha =>
      dateTime().withDefault(currentDateAndTime)();
}