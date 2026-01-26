class TareaComentario {
  final String id;

  /// Puede ser `tarea.id` o `groupId` (tarea lógica)
  final String tareaId;
  final String autorId;
  final String mensaje;
  final DateTime creadoEn;

  TareaComentario({
    required this.id,
    required this.tareaId,
    required this.autorId,
    required this.mensaje,
    required this.creadoEn,
  });
}
