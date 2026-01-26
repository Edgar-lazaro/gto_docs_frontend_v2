class ReporteComentario {
  final String id;
  final String reporteId;
  final String autorId;
  final String mensaje;
  final DateTime creadoEn;

  ReporteComentario({
    required this.id,
    required this.reporteId,
    required this.autorId,
    required this.mensaje,
    required this.creadoEn,
  });
}