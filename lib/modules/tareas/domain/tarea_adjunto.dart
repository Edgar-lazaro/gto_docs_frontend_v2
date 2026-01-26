enum TareaAdjuntoTipo { foto, documento }

class TareaAdjunto {
  final String id;

  /// Puede ser `tarea.id` o `groupId` (tarea lógica)
  final String tareaId;
  final TareaAdjuntoTipo tipo;
  final String nombre;
  final String localPath;
  final String? mimeType;
  final String? remoteUrl;
  final DateTime creadoEn;

  TareaAdjunto({
    required this.id,
    required this.tareaId,
    required this.tipo,
    required this.nombre,
    required this.localPath,
    this.mimeType,
    this.remoteUrl,
    required this.creadoEn,
  });
}
