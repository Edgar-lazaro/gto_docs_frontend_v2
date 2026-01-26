enum ParticipanteRol {
  responsable,
  observador,
}

class Participante {
  final String userId;
  final ParticipanteRol rol;

  Participante({
    required this.userId,
    required this.rol,
  });
}