import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/glpi_repository.dart';
import '../domain/glpi_ticket.dart';

class GlpiRepositoryImpl implements GlpiRepository {
  final AppDatabase db;

  GlpiRepositoryImpl({required this.db});

  @override
  Future<void> crearTicket(GlpiTicket ticket, {String? entidadId}) async {
    await db.into(db.syncQueueTable).insert(
      SyncQueueTableCompanion.insert(
        entidad: 'glpi_ticket',
        entidadId: (entidadId != null && entidadId.trim().isNotEmpty)
            ? entidadId.trim()
            : DateTime.now().millisecondsSinceEpoch.toString(),
        accion: 'create',
        payload: Value(ticket.toJson()),
      ),
    );
  }
}