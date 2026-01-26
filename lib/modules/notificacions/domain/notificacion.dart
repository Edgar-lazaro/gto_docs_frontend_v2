enum NotificacionTipo {
  reporte,
  tarea,
  evidencia,
  sistema,
}

class Notificacion {
  final String id;
  final NotificacionTipo tipo;
  final String titulo;
  final String mensaje;
  final String? referenciaId; // reporteId, tareaId, etc
  final DateTime creadaEn;
  final bool leida;

  Notificacion({
    required this.id,
    required this.tipo,
    required this.titulo,
    required this.mensaje,
    this.referenciaId,
    required this.creadaEn,
    this.leida = false,
  });
}