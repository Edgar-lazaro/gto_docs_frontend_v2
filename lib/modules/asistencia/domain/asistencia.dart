enum TipoAsistencia {
  entrada,
  salida,
}

class Asistencia {
  final int id;
  final String usuarioId;
  final DateTime fechaHora;
  final TipoAsistencia tipo;
  final String metodo; // manual / biometrico (futuro)
  final bool sincronizado;

  Asistencia({
    required this.id,
    required this.usuarioId,
    required this.fechaHora,
    required this.tipo,
    required this.metodo,
    required this.sincronizado,
  });
}