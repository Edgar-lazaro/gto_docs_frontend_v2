import 'glpi_ticket_user.dart';

class GlpiTicket {
  final String titulo;
  final String descripcion;
  /// Fecha/hora de creación (ISO-8601 esperado por backend)
  final DateTime fecha;

  /// M:M: varios pueden asignar
  final List<String> asignadores;

  /// M:M: varios pueden ejecutar/hacer la tarea
  final List<String> asignados;

  final String categoria;
  final String prioridad;
  final List<GlpiTicketUser> users;
  final Map<String, dynamic>? metadata;

  GlpiTicket({
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.asignadores,
    required this.asignados,
    required this.categoria,
    required this.prioridad,
    required this.users,
    this.metadata,
  });

  Map<String, dynamic> toJson() => {
        'titulo': titulo,
        'descripcion': descripcion,
        'fecha': fecha.toIso8601String(),
        'asignadores': asignadores,
        'asignados': asignados,
        'categoria': categoria,
        'prioridad': prioridad,
        'users': users.map((u) => u.toJson()).toList(),
        if (metadata != null) 'metadata': metadata,
      };
}