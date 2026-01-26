enum ReporteEstado {
  enviado,     // recién creado
  enProceso,   // ya tomado / asignado
  resuelto,    // solucionado
  rechazado,   // no aplica / duplicado
}

extension ReporteEstadoX on ReporteEstado {
  String get asString {
    switch (this) {
      case ReporteEstado.enviado:
        return 'enviado';
      case ReporteEstado.enProceso:
        return 'en_proceso';
      case ReporteEstado.resuelto:
        return 'resuelto';
      case ReporteEstado.rechazado:
        return 'rechazado';
    }
  }

  static ReporteEstado fromString(String value) {
    switch (value) {
      case 'en_proceso':
        return ReporteEstado.enProceso;
      case 'resuelto':
        return ReporteEstado.resuelto;
      case 'rechazado':
        return ReporteEstado.rechazado;
      case 'enviado':
      default:
        return ReporteEstado.enviado;
    }
  }
}

class Reporte {
  final String id;                 // UUID local
  final String titulo;             // corto y claro
  final String descripcion;        // detalle del problema
  final String categoria;          // Mantenimiento, Seguridad, TI, etc.
  final String area;               // área/gerencia
  final String? activo;            // opcional (banda, vehículo, equipo)
  final String? ubicacion;         // opcional (puerta, hangar)
  final String creadoPor;          // userId (requester)
  final DateTime creadoEn;
  final ReporteEstado estado;

  // Relación con GLPI (opcional)
  final String? glpiTicketId;      // ID en backend/GLPI cuando exista

  // Extra para crecer (IA, contexto, sensores, etc.)
  final Map<String, dynamic>? metadata;

  Reporte({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.categoria,
    required this.area,
    required this.creadoPor,
    required this.creadoEn,
    this.estado = ReporteEstado.enviado,
    this.activo,
    this.ubicacion,
    this.glpiTicketId,
    this.metadata,
  });

  Reporte copyWith({
    ReporteEstado? estado,
    String? glpiTicketId,
  }) {
    return Reporte(
      id: id,
      titulo: titulo,
      descripcion: descripcion,
      categoria: categoria,
      area: area,
      creadoPor: creadoPor,
      creadoEn: creadoEn,
      estado: estado ?? this.estado,
      activo: activo,
      ubicacion: ubicacion,
      glpiTicketId: glpiTicketId ?? this.glpiTicketId,
      metadata: metadata,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'titulo': titulo,
        'descripcion': descripcion,
        'categoria': categoria,
        'area': area,
        'activo': activo,
        'ubicacion': ubicacion,
        'creadoPor': creadoPor,
        'creadoEn': creadoEn.toIso8601String(),
        'estado': estado.asString,
        'glpiTicketId': glpiTicketId,
        'metadata': metadata,
      };
}