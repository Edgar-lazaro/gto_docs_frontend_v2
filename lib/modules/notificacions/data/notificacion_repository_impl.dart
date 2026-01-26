import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../domain/notificacion.dart';

class NotificacionRepository {
  final AppDatabase db;

  const NotificacionRepository(this.db);

  Future<void> crear({
    required String? tipo,
    required String titulo,
    required String mensaje,
    required String? referenciaId,
  }) async {
    await db.into(db.notificationsTable).insert(
      NotificationsTableCompanion.insert(
        id: const Uuid().v4(),
        tipo: Value(tipo ?? ''),
        titulo: titulo,
        mensaje: mensaje,
        leida: Value(false),
      ),
    );
  }

  Future<List<Notificacion>> obtenerTodas() async {
    final query = db.select(db.notificationsTable)
      ..orderBy([(t) => OrderingTerm.desc(t.fecha)]);

    final rows = await query.get();

    return rows
        .map(
          (n) => Notificacion(
            id: n.id,
            tipo: NotificacionTipo.values.byName(n.tipo),
            titulo: n.titulo,
            mensaje: n.mensaje,
            creadaEn: n.fecha,
            leida: n.leida,
          ),
        )
        .toList();
  }

  Future<void> marcarLeida(String id) async {
    await (db.update(db.notificationsTable)
          ..where((n) => n.id.equals(id)))
        .write(
      const NotificationsTableCompanion(
        leida: Value(true),
      ),
    );
  }

  Future<void> marcarTodasLeidas() async {
    await (db.update(db.notificationsTable)
          ..where((n) => n.leida.equals(false)))
        .write(
      const NotificationsTableCompanion(
        leida: Value(true),
      ),
    );
  }

  Future<int> contarNoLeidas() async {
    final query = db.select(db.notificationsTable)
      ..where((n) => n.leida.equals(false));

    final rows = await query.get();
    return rows.length;
  }

  Stream<int> watchNoLeidas() {
    final query = db.select(db.notificationsTable)
      ..where((n) => n.leida.equals(false));

    return query.watch().map((rows) => rows.length);
  }
}