import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/providers.dart';
import 'pdf_upload_api_repository.dart';

final pdfUploadApiRepositoryProvider = Provider<PdfUploadApiRepository>((ref) {
  return PdfUploadApiRepository(dio: ref.read(dioProvider));
});
