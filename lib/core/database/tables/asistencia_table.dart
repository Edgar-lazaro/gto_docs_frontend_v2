import 'package:drift/drift.dart';

class AsistenciaTable extends Table {
  // ID local autoincremental
  IntColumn get id => integer().autoIncrement()();

  // Usuario (AD / employeeId)
  TextColumn get usuarioId => text()();

  // Fecha y hora exacta del registro
  DateTimeColumn get fechaHora => dateTime()();

  // entrada | salida
  TextColumn get tipo =>
      text().check(CustomExpression<bool>("tipo IN ('entrada', 'salida')"))();

  // manual | biometrico (futuro)
  TextColumn get metodo => text().withDefault(const Constant('manual'))();

  // ¿ya se envió al backend?
  BoolColumn get sincronizado => boolean().withDefault(const Constant(false))();

  // Auditoría
  DateTimeColumn get creadoEn => dateTime().withDefault(currentDateAndTime)();
}
