import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'etp_models.dart';

class EtpChecklistPdf {
  static Future<Uint8List> build({
    required EtpChecklistDefinition definition,
    required EtpChecklistDraft draft,
    String leftLogoAsset = 'assets/img/login.png',
    String rightLogoAsset = 'assets/img/logo_ae.png',
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

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (context) {
          return [
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
            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Expanded(child: pw.Text('Nombre: ${draft.userName}')),
                pw.Expanded(
                  child: pw.Text(
                    'Fecha: $dia/$mes/$year',
                    textAlign: pw.TextAlign.end,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 5),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Expanded(child: pw.Text('Area: ${draft.checklistName}')),
                pw.Expanded(child: pw.Text('', textAlign: pw.TextAlign.end)),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              cellAlignment: pw.Alignment.center,
              headerDecoration: pw.BoxDecoration(
                color: PdfColors.grey300,
                border: pw.Border.all(width: 1, color: PdfColors.black),
              ),
              cellDecoration: (index, data, rowNum) => pw.BoxDecoration(
                border: pw.Border.all(width: 1, color: PdfColors.black),
              ),
              headers: const [
                'Sistema/Equipo',
                'Cable Roto',
                'Falla Red',
                'Anomalías',
                'Observaciones',
              ],
              data: draft.items.map((it) {
                return [
                  it.label,
                  it.cableRoto ? 'X' : '',
                  it.fallaRed ? 'X' : '',
                  it.anomalias,
                  it.observaciones,
                ];
              }).toList(),
            ),
            pw.SizedBox(height: 20),
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(width: 2, color: PdfColors.blue),
                borderRadius: pw.BorderRadius.circular(6),
              ),
              padding: const pw.EdgeInsets.all(10),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Resumen',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    'Total de sistemas revisados: ${draft.items.length}',
                    style: const pw.TextStyle(fontSize: 12),
                  ),
                  pw.Text(
                    'Sistemas con anomalías: ${draft.items.where((p) => p.anomalias.isNotEmpty).length}',
                    style: const pw.TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }
}
