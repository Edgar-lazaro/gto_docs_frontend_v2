class GeneratedPdf {
  final String id;
  final String filename;
  final String localPath;
  final DateTime createdAt;

  final String createdByUserId;
  final String createdByName;
  final String area;
  final int? gerenciaId;

  final int? jefaturaId;
  final int? checklistId;
  final String? checklistNombre;
  final String source; // 'checklist' | 'reporte'

  final bool uploaded;
  final String? uploadedUrl;

  const GeneratedPdf({
    required this.id,
    required this.filename,
    required this.localPath,
    required this.createdAt,
    required this.createdByUserId,
    required this.createdByName,
    required this.area,
    required this.gerenciaId,
    required this.source,
    this.jefaturaId,
    this.checklistId,
    this.checklistNombre,
    this.uploaded = false,
    this.uploadedUrl,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'filename': filename,
        'localPath': localPath,
        'createdAt': createdAt.toIso8601String(),
        'createdByUserId': createdByUserId,
        'createdByName': createdByName,
        'area': area,
        'gerenciaId': gerenciaId,
        'jefaturaId': jefaturaId,
        'checklistId': checklistId,
        'checklistNombre': checklistNombre,
        'source': source,
        'uploaded': uploaded,
        'uploadedUrl': uploadedUrl,
      };

  static GeneratedPdf fromJson(Map<String, dynamic> json) {
    return GeneratedPdf(
      id: (json['id'] ?? '').toString(),
      filename: (json['filename'] ?? '').toString(),
      localPath: (json['localPath'] ?? '').toString(),
      createdAt:
          DateTime.tryParse((json['createdAt'] ?? '').toString()) ??
              DateTime.fromMillisecondsSinceEpoch(0),
      createdByUserId: (json['createdByUserId'] ?? '').toString(),
      createdByName: (json['createdByName'] ?? '').toString(),
      area: (json['area'] ?? '').toString(),
      gerenciaId: _asInt(json['gerenciaId']),
      jefaturaId: _asInt(json['jefaturaId']),
      checklistId: _asInt(json['checklistId']),
      checklistNombre: (json['checklistNombre'] ?? '').toString().isEmpty
          ? null
          : (json['checklistNombre'] ?? '').toString(),
      source: (json['source'] ?? '').toString(),
      uploaded: json['uploaded'] == true,
      uploadedUrl: (json['uploadedUrl'] ?? '').toString().isEmpty
          ? null
          : (json['uploadedUrl'] ?? '').toString(),
    );
  }

  GeneratedPdf copyWith({
    bool? uploaded,
    String? uploadedUrl,
  }) {
    return GeneratedPdf(
      id: id,
      filename: filename,
      localPath: localPath,
      createdAt: createdAt,
      createdByUserId: createdByUserId,
      createdByName: createdByName,
      area: area,
      gerenciaId: gerenciaId,
      source: source,
      jefaturaId: jefaturaId,
      checklistId: checklistId,
      checklistNombre: checklistNombre,
      uploaded: uploaded ?? this.uploaded,
      uploadedUrl: uploadedUrl ?? this.uploadedUrl,
    );
  }
}

int? _asInt(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  return int.tryParse(v.toString());
}
