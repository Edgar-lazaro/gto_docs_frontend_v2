import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'generated_pdf.dart';

class GeneratedPdfRepository {
  static const _key = 'generated_pdfs_v1';

  final SharedPreferences prefs;

  GeneratedPdfRepository(this.prefs);

  List<GeneratedPdf> listAll() {
    final raw = prefs.getStringList(_key) ?? const <String>[];
    final out = <GeneratedPdf>[];
    for (final s in raw) {
      try {
        final m = jsonDecode(s);
        if (m is Map) {
          out.add(GeneratedPdf.fromJson(m.cast<String, dynamic>()));
        }
      } catch (_) {
     
      }
    }
    out.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return out;
  }

  Future<void> add(GeneratedPdf pdf) async {
    final list = listAll();
    final next = [pdf, ...list]
        .map((e) => jsonEncode(e.toJson()))
        .toList(growable: false);
    await prefs.setStringList(_key, next);
  }

  Future<void> markUploaded({
    required String id,
    required String url,
  }) async {
    final list = listAll();
    final next = list
        .map((e) => e.id == id ? e.copyWith(uploaded: true, uploadedUrl: url) : e)
        .map((e) => jsonEncode(e.toJson()))
        .toList(growable: false);
    await prefs.setStringList(_key, next);
  }

  GeneratedPdf? latestForChecklist({
    required int jefaturaId,
    required int checklistId,
  }) {
    for (final p in listAll()) {
      if (p.jefaturaId == jefaturaId && p.checklistId == checklistId) return p;
    }
    return null;
  }
}
