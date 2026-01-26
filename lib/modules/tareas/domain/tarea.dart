enum TareaEstado {
  pendiente,
  enProceso,
  completada,
}

class Tarea {
  final String id;
  final String? groupId;
  final String reporteId;
  final String titulo;
  final String descripcion;
  final String? creadoPor;
  final String asignadoA;
  final TareaEstado estado;

  Tarea({
    required this.id,
    this.groupId,
    required this.reporteId,
    required this.titulo,
    required this.descripcion,
    this.creadoPor,
    required this.asignadoA,
    this.estado = TareaEstado.pendiente,
  });
}