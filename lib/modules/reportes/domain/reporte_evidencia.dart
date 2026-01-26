enum EvidenciaTipo {
  imagen,
  documento,
  video,
  otro,
}

class ReporteEvidencia {
  final String id;
  final String reporteId;
  final EvidenciaTipo tipo;
  final String nombre;
  final String localPath;     // archivo local (offline)
  final String? remoteUrl;    // URL backend cuando se sincroniza
  final DateTime creadoEn;

  ReporteEvidencia({
    required this.id,
    required this.reporteId,
    required this.tipo,
    required this.nombre,
    required this.localPath,
    this.remoteUrl,
    required this.creadoEn,
  });
}