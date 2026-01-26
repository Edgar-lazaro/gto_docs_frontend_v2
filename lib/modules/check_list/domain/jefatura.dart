class Jefatura {
  final int id;
  final String nombre;
  final int gerencia;
  final String? img;

  const Jefatura({
    required this.id,
    required this.nombre,
    required this.gerencia,
    this.img,
  });

  factory Jefatura.fromJson(Map<String, dynamic> json) {
    final id = json['id'] ?? json['jefatura_id'] ?? json['jefaturaId'];
    final gerencia =
        json['gerencia'] ?? json['gerencia_id'] ?? json['gerenciaId'];

    return Jefatura(
      id: int.tryParse(id?.toString() ?? '') ?? 0,
      nombre: (json['nombre_jefatura'] ?? json['nombre'] ?? '').toString(),
      gerencia: int.tryParse(gerencia?.toString() ?? '') ?? 0,
      img: (json['img'] ?? json['imagen'] ?? '').toString().trim().isEmpty
          ? null
          : (json['img'] ?? json['imagen']).toString(),
    );
  }
}
