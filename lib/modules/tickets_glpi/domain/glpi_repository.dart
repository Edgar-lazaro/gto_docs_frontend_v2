import 'glpi_ticket.dart';

abstract class GlpiRepository {
  Future<void> crearTicket(GlpiTicket ticket, {String? entidadId});
}