class Activo {
  final String id;
  final String nombre;
  final String tipo;
  final String ubicacion;
  final String estado;
  final int cantidad;
  final String? descripcion;
  final String? img;

  Activo({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.ubicacion,
    required this.estado,
    this.cantidad = 0,
    this.descripcion,
    this.img,
  });

  factory Activo.fromJson(Map<String, dynamic> json) {
    final id = (json['id'] ?? json['activo_id'] ?? json['activoId'] ?? '')
        .toString();
    final nombre = (json['nombre'] ?? json['name'] ?? '').toString();
    final tipo = (json['categoria'] ?? json['tipo'] ?? '').toString();
    final ubicacion = (json['ubicacion'] ?? json['location'] ?? '').toString();
    final estado = (json['estado'] ?? '').toString();

    final cantidadRaw = json['cantidad'];
    final cantidad = cantidadRaw is int
        ? cantidadRaw
        : int.tryParse(cantidadRaw?.toString() ?? '') ?? 0;

    final descripcion = (json['descripcion'] ?? '').toString().trim();
    final img = (json['img'] ?? json['imagen'] ?? '').toString().trim();

    return Activo(
      id: id,
      nombre: nombre,
      tipo: tipo,
      ubicacion: ubicacion,
      estado: estado,
      cantidad: cantidad,
      descripcion: descripcion.isEmpty ? null : descripcion,
      img: img.isEmpty ? null : img,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'tipo': tipo,
      'categoria': tipo,
      'ubicacion': ubicacion,
      'estado': estado,
      'cantidad': cantidad,
      'descripcion': descripcion,
      'img': img,
      'imagen': img,
    }..removeWhere((_, v) => v == null);
  }

  Activo copyWith({
    String? id,
    String? nombre,
    String? tipo,
    String? ubicacion,
    String? estado,
    int? cantidad,
    String? descripcion,
    String? img,
  }) {
    return Activo(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      tipo: tipo ?? this.tipo,
      ubicacion: ubicacion ?? this.ubicacion,
      estado: estado ?? this.estado,
      cantidad: cantidad ?? this.cantidad,
      descripcion: descripcion ?? this.descripcion,
      img: img ?? this.img,
    );
  }
}
