import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class PdfUploadApiRepository {
  final Dio dio;

  PdfUploadApiRepository({required this.dio});

  Future<FormData> _buildFormData({
    required File file,
    required String filename,
    required Map<String, dynamic> metadata,
  }) async {
    return FormData.fromMap({
      ...metadata,
      'filename': filename,
      'file': await MultipartFile.fromFile(
        file.path,
        filename: filename,
        contentType: MediaType('application', 'pdf'),
      ),
    });
  }

  Future<String> uploadPdf({
    required File file,
    required String filename,
    required Map<String, dynamic> metadata,
  }) async {
    final source = (metadata['source'] ?? '').toString().toLowerCase().trim();

    // Prefer the new endpoints (served under baseUrl .../api).
    final preferred = <String>[
      if (source == 'checklist') '/checklists/adjuntos',
      if (source == 'reporte') '/reportes/adjuntos',
      // Safe fallback if source is missing/unknown.
      if (source != 'checklist' && source != 'reporte') '/tareas/adjuntos',
    ];

    // Legacy/alternative candidates kept for backwards compatibility.
    final candidates = <String>[
      ...preferred,
      '/pdfs',
      '/pdfs/upload',
      '/documentos/pdf',
      '/documentos_pdf',
      '/checklists/pdf',
    ];

    DioException? last;
    for (final path in candidates) {
      try {
        // IMPORTANT: FormData is single-use (finalized after sending).
        // Rebuild it for every attempt.
        final formData = await _buildFormData(
          file: file,
          filename: filename,
          metadata: metadata,
        );
        final res = await dio.post(path, data: formData);
        final data = res.data;
        if (data is Map) {
          final m = data.cast<String, dynamic>();
          final url =
              (m['url'] ?? m['publicUrl'] ?? m['url_storage'] ?? '').toString();
          if (url.isNotEmpty) return url;
        }
        // Respuesta sin URL: este endpoint no es compatible para nuestra necesidad.
        // Probamos el siguiente candidato.
        continue;
      } on DioException catch (e) {
        last = e;
        if (e.response?.statusCode == 404) continue;
        rethrow;
      }
    }

    if (last != null) throw last;
    throw StateError('No se encontró un endpoint para subir PDF');
  }
}
