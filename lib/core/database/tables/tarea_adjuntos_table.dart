import 'package:drift/drift.dart';

class TareaAdjuntosTable extends Table {
  TextColumn get id => text()();
  TextColumn get tareaId => text()();

  /// 'foto' o 'documento'
  TextColumn get tipo => text()();

  TextColumn get nombre => text()();
  TextColumn get localPath => text()();
  TextColumn get mimeType => text().nullable()();
  TextColumn get remoteUrl => text().nullable()();
  DateTimeColumn get creadoEn => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
