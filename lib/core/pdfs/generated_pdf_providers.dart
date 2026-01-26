import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generated_pdf_repository.dart';
import 'generated_pdf.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider no inicializado');
});

final generatedPdfRepositoryProvider = Provider<GeneratedPdfRepository>((ref) {
  return GeneratedPdfRepository(ref.read(sharedPreferencesProvider));
});

final generatedPdfsProvider = FutureProvider<List<GeneratedPdf>>((ref) async {
  return ref.read(generatedPdfRepositoryProvider).listAll();
});
