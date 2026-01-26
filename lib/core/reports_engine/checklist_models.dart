import 'package:flutter/foundation.dart';

@immutable
class ChecklistItemDefinition {
  final String id;
  final String label;

  const ChecklistItemDefinition({required this.id, required this.label});
}

@immutable
class ChecklistReportDefinition {
  final String id;
  final String title;
  final String pdfHeaderTitle;
  final String locationLabel;
  final List<ChecklistItemDefinition> items;

  const ChecklistReportDefinition({
    required this.id,
    required this.title,
    this.pdfHeaderTitle = 'REPORTE DE MANTENIMIENTO PREVENTIVO',
    this.locationLabel = 'Site',
    required this.items,
  });
}

@immutable
class ChecklistItemAnswer {
  final String itemId;
  final String label;
  final bool cumple;
  final bool noCumple;
  final String observacion;

  final List<String> imagePaths;

  const ChecklistItemAnswer({
    required this.itemId,
    required this.label,
    required this.cumple,
    required this.noCumple,
    required this.observacion,
    required this.imagePaths,
  });
}

@immutable
class ChecklistReportDraft {
  final String reportTypeId;
  final String reportTitle;

  final String site;
  final String responsable;
  final String folio;

  final DateTime createdAt;
  final List<ChecklistItemAnswer> items;

  const ChecklistReportDraft({
    required this.reportTypeId,
    required this.reportTitle,
    required this.site,
    required this.responsable,
    required this.folio,
    required this.createdAt,
    required this.items,
  });
}
