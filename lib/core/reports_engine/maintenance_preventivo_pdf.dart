import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'checklist_models.dart';

class MaintenancePreventivoPdf {
  static Future<Uint8List> build({
    required ChecklistReportDefinition definition,
    required ChecklistReportDraft draft,
    String leftLogoAsset = 'assets/img/login.png',
    String rightLogoAsset = 'assets/img/logo_ae.png',
    int rowsPerTable = 15,
  }) async {
    final pdf = pw.Document();

    final now = draft.createdAt;
    final dia = DateFormat('dd').format(now);
    final mes = DateFormat('MM').format(now);
    final year = DateFormat('yyyy').format(now);

    final imageLeft = (await rootBundle.load(
      leftLogoAsset,
    )).buffer.asUint8List();
    final imageRight = (await rootBundle.load(
      rightLogoAsset,
    )).buffer.asUint8List();

    final chunks = _chunk(draft.items, rowsPerTable);

    final imagesByItemId = <String, List<Uint8List>>{};
    for (final item in draft.items) {
      if (item.imagePaths.isEmpty) continue;
      final bytesList = <Uint8List>[];
      for (final path in item.imagePaths) {
        try {
          final bytes = await File(path).readAsBytes();
          bytesList.add(bytes);
        } catch (e) {
          debugPrint('Error loading image $path: $e');
        }
      }
      if (bytesList.isNotEmpty) {
        imagesByItemId[item.itemId] = bytesList;
      }
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (context) {
          final widgets = <pw.Widget>[];

          widgets.add(
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.SizedBox(
                    width: 80,
                    height: 80,
                    child: pw.Image(
                      pw.MemoryImage(imageLeft),
                      fit: pw.BoxFit.contain,
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      definition.pdfHeaderTitle,
                      style: pw.TextStyle(
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.SizedBox(
                    width: 80,
                    height: 80,
                    child: pw.Image(
                      pw.MemoryImage(imageRight),
                      fit: pw.BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          );

          widgets.add(pw.SizedBox(height: 10));

          widgets.add(
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(
                  children: [
                    pw.Text(
                      '${definition.locationLabel}: ',
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      draft.site.isEmpty ? '_______________' : draft.site,
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: draft.site.isEmpty
                            ? PdfColors.grey600
                            : PdfColors.black,
                      ),
                    ),
                  ],
                ),
                pw.Expanded(
                  child: pw.Text(
                    'Fecha: $dia/$mes/$year',
                    textAlign: pw.TextAlign.end,
                  ),
                ),
              ],
            ),
          );

          widgets.add(pw.SizedBox(height: 5));

          widgets.add(
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(
                  children: [
                    pw.Text(
                      'Responsable: ',
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      draft.responsable.isEmpty
                          ? '_______________'
                          : draft.responsable,
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: draft.responsable.isEmpty
                            ? PdfColors.grey600
                            : PdfColors.black,
                      ),
                    ),
                  ],
                ),
                pw.Expanded(
                  child: pw.Text(
                    'Folio: ${draft.folio.isEmpty ? '_______________' : draft.folio}',
                    textAlign: pw.TextAlign.end,
                  ),
                ),
              ],
            ),
          );

          widgets.add(pw.SizedBox(height: 20));

          for (var chunkIndex = 0; chunkIndex < chunks.length; chunkIndex++) {
            final part = chunks[chunkIndex];

            widgets.add(
              pw.Text(
                definition.title,
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            );
            widgets.add(pw.SizedBox(height: 5));

            widgets.add(_buildTable(part));

            widgets.add(pw.SizedBox(height: 20));

            final hasImages = part.any(
              (i) => (imagesByItemId[i.itemId] ?? const []).isNotEmpty,
            );
            if (hasImages) {
              widgets.add(
                pw.Text(
                  'Evidencias fotográficas - ${definition.title}',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              );
              widgets.add(pw.SizedBox(height: 10));

              for (var i = 0; i < part.length; i++) {
                final item = part[i];
                final bytesList =
                    imagesByItemId[item.itemId] ?? const <Uint8List>[];
                if (bytesList.isEmpty) continue;

                widgets.add(
                  pw.Text(
                    '${_globalIndex(draft.items, item.itemId) + 1}. ${item.label}',
                    style: pw.TextStyle(
                      fontSize: 11,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                );
                widgets.add(pw.SizedBox(height: 5));

                widgets.add(
                  pw.Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: bytesList
                        .map(
                          (b) => pw.Container(
                            width: 160,
                            height: 120,
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.grey600),
                            ),
                            child: pw.Image(
                              pw.MemoryImage(b),
                              fit: pw.BoxFit.cover,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );

                widgets.add(pw.SizedBox(height: 12));
              }
            }

            if (chunkIndex != chunks.length - 1) {
              widgets.add(pw.SizedBox(height: 12));
            }
          }

          return widgets;
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildTable(List<ChecklistItemAnswer> items) {
    return pw.Table(
      border: pw.TableBorder.all(width: 1, color: PdfColors.black),
      columnWidths: {
        0: const pw.FixedColumnWidth(180),
        1: const pw.FixedColumnWidth(60),
        2: const pw.FixedColumnWidth(60),
        3: const pw.FlexColumnWidth(),
      },
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey300),
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(
                'Generalidades',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(
                'Cumple',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(
                'No cumple',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(
                'Observaciones',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ),
          ],
        ),
        ...items.map((product) {
          return pw.TableRow(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                  product.label,
                  style: const pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                  product.cumple ? 'X' : '',
                  textAlign: pw.TextAlign.center,
                  style: const pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                  product.noCumple ? 'X' : '',
                  textAlign: pw.TextAlign.center,
                  style: const pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                  product.observacion,
                  style: const pw.TextStyle(fontSize: 10),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  static List<List<T>> _chunk<T>(List<T> list, int size) {
    if (size <= 0) return [list];
    final out = <List<T>>[];
    for (var i = 0; i < list.length; i += size) {
      out.add(list.sublist(i, i + size > list.length ? list.length : i + size));
    }
    return out;
  }

  static int _globalIndex(List<ChecklistItemAnswer> all, String itemId) {
    return all.indexWhere((e) => e.itemId == itemId);
  }
}
