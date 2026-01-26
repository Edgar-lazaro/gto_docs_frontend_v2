import 'package:flutter/foundation.dart';

@immutable
class EtpChecklistItemDefinition {
  final String id;
  final String label;

  const EtpChecklistItemDefinition({required this.id, required this.label});
}

@immutable
class EtpChecklistDefinition {
  final String id;
  final String title;
  final String pdfHeaderTitle;
  final List<EtpChecklistItemDefinition> items;

  const EtpChecklistDefinition({
    required this.id,
    required this.title,
    required this.pdfHeaderTitle,
    required this.items,
  });
}

@immutable
class EtpChecklistItemAnswer {
  final String itemId;
  final String label;
  final bool cableRoto;
  final bool fallaRed;
  final String anomalias;
  final String observaciones;

  const EtpChecklistItemAnswer({
    required this.itemId,
    required this.label,
    required this.cableRoto,
    required this.fallaRed,
    required this.anomalias,
    required this.observaciones,
  });
}

@immutable
class EtpChecklistDraft {
  final String reportTypeId;
  final String reportTitle;

  final String userName;
  final String checklistName;

  final DateTime createdAt;
  final List<EtpChecklistItemAnswer> items;

  const EtpChecklistDraft({
    required this.reportTypeId,
    required this.reportTitle,
    required this.userName,
    required this.checklistName,
    required this.createdAt,
    required this.items,
  });
}
