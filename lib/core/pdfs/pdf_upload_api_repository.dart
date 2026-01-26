import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class PdfUploadApiRepository {
  final Dio dio;

  PdfUploadApiRepository({required this.dio});

  Future<String> uploadPdf({
    required File file,
    required String filename,
    required Map<String, dynamic> metadata,
  }) async {
    final formData = FormData.fromMap({
      ...metadata,
      'filename': filename,
      'file': await MultipartFile.fromFile(
        file.path,
        filename: filename,
        contentType: MediaType('application', 'pdf'),
      ),
    });

    final candidates = <String>[
      '/pdfs',
      '/pdfs/upload',
      '/documentos/pdf',
      '/documentos_pdf',
      '/checklists/pdf',
    ];

    DioException? last;
    for (final path in candidates) {
      try {
        final res = await dio.post(path, data: formData);
        final data = res.data;
        if (data is Map) {
          final m = data.cast<String, dynamic>();
          final url =
              (m['url'] ?? m['publicUrl'] ?? m['url_storage'] ?? '').toString();
          if (url.isNotEmpty) return url;
        }
        // Si no devuelve URL, devolvemos un OK simbólico.
        return 'OK';
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
