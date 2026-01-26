import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_providers.dart';
import '../../../core/auth/role_utils.dart';
import '../../../core/network/lan_gate.dart';
import '../../../core/pdfs/generated_pdf.dart';
import '../../../core/pdfs/generated_pdf_providers.dart';
import '../../../core/pdfs/pdf_upload_providers.dart';
import '../../../core/reports_engine/checklist_models.dart';
import '../../../core/reports_engine/checklist_report_form.dart';
import '../../../core/reports_engine/etp_models.dart';
import '../../../core/reports_engine/etp_report_form.dart';
import '../../../core/reports_engine/maintenance_preventivo_pdf.dart';
import '../../../core/reports_engine/etp_checklist_pdf.dart';
import '../../../core/reports_engine/pdf_file_service.dart';
import '../../../core/reports_engine/reports_catalog.dart';
import '../domain/checklist_existente.dart';
import '../../../shared/ui/theme/gerencia_config.dart';
import '../../../shared/ui/widgets/gerencia_app_bar.dart';
import '../../tareas/domain/tarea.dart';
import '../../tareas/presentation/tareas_providers.dart';

class ChecklistRunnerPage extends ConsumerStatefulWidget {
  final GerenciaTheme theme;
  final int jefaturaId;
  final String jefaturaNombre;
  final ChecklistExistente checklist;

  const ChecklistRunnerPage({
    super.key,
    required this.theme,
    required this.jefaturaId,
    required this.jefaturaNombre,
    required this.checklist,
  });

  @override
  ConsumerState<ChecklistRunnerPage> createState() =>
      _ChecklistRunnerPageState();
}

class _ChecklistRunnerPageState extends ConsumerState<ChecklistRunnerPage> {
  bool _busy = false;
  GeneratedPdf? _last;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kind = _resolveKindForChecklist(
      funcionForm: widget.checklist.funcionForm,
      checklistNombre: widget.checklist.nombre,
    );

    return Scaffold(
      appBar: GerenciaAppBar(
        theme: widget.theme,
        title: widget.checklist.nombre,
        actions: [
          IconButton(
            tooltip: 'Subir PDF (LAN)',
            icon: const Icon(Icons.cloud_upload),
            onPressed: _busy ? null : _onUpload,
          ),
        ],
      ),
      body: Stack(
        children: [
          if (kind == _ChecklistKind.manttoSite)
            ChecklistReportForm(
              definition: ReportsCatalog.mantenimientoSites,
              onSubmit: _onSubmitMaintenance,
            )
          else if (kind == _ChecklistKind.manttoMostrador)
            ChecklistReportForm(
              definition: ReportsCatalog.mantenimientoMostrador,
              onSubmit: _onSubmitMaintenance,
            )
          else if (kind == _ChecklistKind.etp)
            EtpChecklistForm(
              definition: ReportsCatalog.checklistEtp,
              userName: ref.read(authControllerProvider).user?.nombre ?? '',
              checklistName: widget.checklist.nombre,
              onSubmit: _onSubmitEtp,
            )
          else
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Este checklist aún no está soportado en v2.\nfuncion_form: ${widget.checklist.funcionForm}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          if (_busy)
            const Positioned.fill(
              child: ColoredBox(
                color: Color(0x88000000),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _onSubmitMaintenance(ChecklistReportDraft draft) async {
    await _generateAndPersist(
      filenamePrefix: 'checklist',
      build: () => MaintenancePreventivoPdf.build(
        definition: _resolveMaintenanceDef(
          funcionForm: widget.checklist.funcionForm,
          checklistNombre: widget.checklist.nombre,
        ),
        draft: draft,
      ),
    );
  }

  Future<void> _onSubmitEtp(EtpChecklistDraft draft) async {
    await _generateAndPersist(
      filenamePrefix: 'checklist',
      build: () => EtpChecklistPdf.build(
        definition: ReportsCatalog.checklistEtp,
        draft: draft,
      ),
    );
  }

  ChecklistReportDefinition _resolveMaintenanceDef({
    required String funcionForm,
    required String checklistNombre,
  }) {
    final kind = _resolveKindForChecklist(
      funcionForm: funcionForm,
      checklistNombre: checklistNombre,
    );
    if (kind == _ChecklistKind.manttoMostrador) {
      return ReportsCatalog.mantenimientoMostrador;
    }
    return ReportsCatalog.mantenimientoSites;
  }

  Future<void> _generateAndPersist({
    required String filenamePrefix,
    required Future<Uint8List> Function() build,
  }) async {
    if (_busy) return;
    setState(() => _busy = true);

    try {
      final bytes = await build();
      final filename =
          '${filenamePrefix}_${widget.checklist.id}_${DateTime.now().millisecondsSinceEpoch}.pdf';

      final file = await PdfFileService.saveToDocuments(
        bytes: bytes,
        filename: filename,
      );

      final user = ref.read(authControllerProvider).user;
      final pdf = GeneratedPdf(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        filename: filename,
        localPath: file.path,
        createdAt: DateTime.now(),
        createdByUserId: user?.id ?? '',
        createdByName: user?.nombre ?? '',
        area: user?.area ?? '',
        gerenciaId: user?.resolvedGerenciaId,
        source: 'checklist',
        jefaturaId: widget.jefaturaId,
        checklistId: widget.checklist.id,
        checklistNombre: widget.checklist.nombre,
      );

      await ref.read(generatedPdfRepositoryProvider).add(pdf);
      setState(() => _last = pdf);

      // Crear tarea automáticamente por checklist generado.
      if (user != null && user.id.trim().isNotEmpty) {
        final tarea = Tarea(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          reporteId: 'checklist:${widget.checklist.id}',
          titulo: pdf.filename,
          descripcion: pdf.filename,
          creadoPor: user.id,
          asignadoA: user.id,
          estado: TareaEstado.pendiente,
        );
        await ref.read(tareaControllerProvider).crearTarea(tarea);
      }

      await PdfFileService.openFile(file);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('No se pudo generar PDF: $e')));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _onUpload() async {
    final pdf =
        _last ??
        ref
            .read(generatedPdfRepositoryProvider)
            .latestForChecklist(
              jefaturaId: widget.jefaturaId,
              checklistId: widget.checklist.id,
            );

    if (pdf == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Primero genera el PDF')));
      return;
    }

    if (!await LanGate.isOnLan()) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Subida disponible solo en LAN corporativa'),
        ),
      );
      return;
    }

    final file = File(pdf.localPath);
    if (!await file.exists()) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se encontró el archivo local del PDF'),
        ),
      );
      return;
    }

    setState(() => _busy = true);
    try {
      final user = ref.read(authControllerProvider).user;
      final url = await ref
          .read(pdfUploadApiRepositoryProvider)
          .uploadPdf(
            file: file,
            filename: pdf.filename,
            metadata: {
              'usuarioId': user?.id,
              'usuarioNombre': user?.nombre,
              'area': user?.area,
              'gerenciaId': user?.resolvedGerenciaId,
              'jefaturaId': widget.jefaturaId,
              'checklistId': widget.checklist.id,
              'checklistNombre': widget.checklist.nombre,
              'source': 'checklist',
            }..removeWhere((_, v) => v == null),
          );

      await ref
          .read(generatedPdfRepositoryProvider)
          .markUploaded(id: pdf.id, url: url);
      ref.invalidate(generatedPdfsProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('PDF subido correctamente')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('No se pudo subir PDF: $e')));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}

enum _ChecklistKind { manttoSite, manttoMostrador, etp, unknown }

String _normalizeToken(String text) {
  final raw = text.trim().toLowerCase();
  // Mantiene solo letras/números para tolerar espacios, guiones, underscores, etc.
  return raw.replaceAll(RegExp(r'[^a-z0-9]+'), '');
}

_ChecklistKind _resolveKind(String funcionForm) {
  final f = _normalizeToken(funcionForm);
  if (f.isEmpty) return _ChecklistKind.unknown;
  if (f.contains('etp')) return _ChecklistKind.etp;

  // Mantto mostrador (ej: "manttoMostra", "mantto_mostrador", etc)
  if (f.contains('mostra') ||
      f.contains('mostrador') ||
      f.contains('mostradores')) {
    return _ChecklistKind.manttoMostrador;
  }

  // Mantto sites (ej: "manttoSite", "mantenimiento_sites")
  if (f.contains('site') || f.contains('sites')) {
    return _ChecklistKind.manttoSite;
  }

  // Telecomm/telecom suele ser un subtipo de mantenimiento; por ahora lo tratamos
  // como mantenimiento (site por defecto) para que el formulario abra.
  if (f.contains('telecomm') || f.contains('telecom') || f.contains('telco')) {
    return _ChecklistKind.manttoSite;
  }

  // Mantenimiento genérico (ej: "mantto", "mantenimiento").
  if (f.contains('mantto') ||
      f.contains('mantenimiento') ||
      f.contains('mntto')) {
    return _ChecklistKind.manttoSite;
  }

  return _ChecklistKind.unknown;
}

_ChecklistKind _resolveKindForChecklist({
  required String funcionForm,
  required String checklistNombre,
}) {
  final kind = _resolveKind(funcionForm);
  final name = _normalizeToken(checklistNombre);

  // Si el backend manda funcion_form genérico (mantto/mantenimiento) pero el
  // nombre trae "mostrador/mostradores", abrimos el formulario correcto.
  final isGenericMantto =
      _normalizeToken(funcionForm).contains('mantto') ||
      _normalizeToken(funcionForm).contains('mantenimiento') ||
      _normalizeToken(funcionForm).contains('mntto');
  final nameSaysMostrador =
      name.contains('mostra') ||
      name.contains('mostrador') ||
      name.contains('mostradores');

  if (kind == _ChecklistKind.manttoSite &&
      isGenericMantto &&
      nameSaysMostrador) {
    return _ChecklistKind.manttoMostrador;
  }

  if (kind == _ChecklistKind.unknown && nameSaysMostrador) {
    return _ChecklistKind.manttoMostrador;
  }

  return kind;
}
