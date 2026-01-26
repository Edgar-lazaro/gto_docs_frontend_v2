import 'dart:io';
import 'dart:typed_data';

import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class PdfFileService {
  static Future<File> saveToTemp({
    required Uint8List bytes,
    required String filename,
  }) async {
    final dir = await getTemporaryDirectory();
    final safeName = filename.endsWith('.pdf') ? filename : '$filename.pdf';
    final file = File(p.join(dir.path, safeName));
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  static Future<File> saveToDocuments({
    required Uint8List bytes,
    required String filename,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final safeName = filename.endsWith('.pdf') ? filename : '$filename.pdf';
    final outDir = Directory(p.join(dir.path, 'pdfs'));
    if (!await outDir.exists()) {
      await outDir.create(recursive: true);
    }
    final file = File(p.join(outDir.path, safeName));
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  static Future<void> openFile(File file) async {
    await OpenFile.open(file.path);
  }
}
