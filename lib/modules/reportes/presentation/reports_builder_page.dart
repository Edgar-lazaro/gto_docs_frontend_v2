import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_providers.dart';
import '../../../core/auth/role_utils.dart';
import '../../../core/pdfs/generated_pdf.dart';
import '../../../core/pdfs/generated_pdf_providers.dart';
import '../../../core/reports_engine/checklist_report_form.dart';
import '../../../core/reports_engine/checklist_models.dart';
import '../../../core/reports_engine/etp_checklist_pdf.dart';
import '../../../core/reports_engine/etp_models.dart';
import '../../../core/reports_engine/etp_report_form.dart';
import '../../../core/reports_engine/maintenance_preventivo_pdf.dart';
import '../../../core/reports_engine/pdf_file_service.dart';
import '../../../core/reports_engine/reports_catalog.dart';
import '../../../shared/ui/theme/gerencia_config.dart';
import '../../../shared/ui/widgets/gerencia_app_bar.dart';
import '../../tareas/domain/tarea.dart';
import '../../tareas/presentation/tareas_providers.dart';

class ReportsBuilderPage extends StatelessWidget {
  final GerenciaTheme theme;

  const ReportsBuilderPage({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final width = MediaQuery.of(context).size.width;
    final horizontalPadding = width >= 1200
        ? 120.0
        : width >= 900
        ? 80.0
        : width >= 600
        ? 60.0
        : 24.0;

    return Scaffold(
      appBar: GerenciaAppBar(theme: theme, title: 'Generador de reportes'),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: isTablet ? 32 : 24,
        ),
        children: [
          Text(
            'Selecciona un formato',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
            ),
          ),
          SizedBox(height: isTablet ? 20 : 16),
          _TemplateTile(
            theme: theme,
            title: 'Mantenimiento - Site',
            subtitle: 'Formato rep_mantto_sites',
            kind: _TemplateKind.manttoSite,
          ),
          _TemplateTile(
            theme: theme,
            title: 'Mantenimiento - Mostrador',
            subtitle: 'Formato rep_mantto_mostra',
            kind: _TemplateKind.manttoMostrador,
          ),
          _TemplateTile(
            theme: theme,
            title: 'Checklist ETP',
            subtitle: 'Formato cl_etp',
            kind: _TemplateKind.etp,
          ),
        ],
      ),
    );
  }
}

enum _TemplateKind { manttoSite, manttoMostrador, etp }

class _TemplateTile extends ConsumerWidget {
  final GerenciaTheme theme;
  final String title;
  final String subtitle;
  final _TemplateKind kind;

  const _TemplateTile({
    required this.theme,
    required this.title,
    required this.subtitle,
    required this.kind,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final cs = Theme.of(context).colorScheme;

    final (icon, accent) = switch (kind) {
      _TemplateKind.manttoSite => (Icons.factory_outlined, cs.primaryContainer),
      _TemplateKind.manttoMostrador => (
        Icons.storefront_outlined,
        cs.secondaryContainer,
      ),
      _TemplateKind.etp => (Icons.checklist_outlined, cs.tertiaryContainer),
    };

    return Card(
      margin: EdgeInsets.only(bottom: isTablet ? 20 : 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            final user = ref.read(authControllerProvider).user;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  switch (kind) {
                    case _TemplateKind.manttoSite:
                      return MaintenanceChecklistRunnerPage(
                        theme: theme,
                        definition: ReportsCatalog.mantenimientoSites,
                        userName: user?.nombre ?? '',
                        userArea: user?.area ?? '',
                      );
                    case _TemplateKind.manttoMostrador:
                      return MaintenanceChecklistRunnerPage(
                        theme: theme,
                        definition: ReportsCatalog.mantenimientoMostrador,
                        userName: user?.nombre ?? '',
                        userArea: user?.area ?? '',
                      );
                    case _TemplateKind.etp:
                      return EtpChecklistRunnerPage(
                        theme: theme,
                        definition: ReportsCatalog.checklistEtp,
                        userName: user?.nombre ?? '',
                        checklistName: user?.area ?? '',
                      );
                  }
                },
              ),
            );
          },
          borderRadius: BorderRadius.circular(isTablet ? 20 : 16),
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 20 : 16),
            child: Row(
              children: [
                Container(
                  width: isTablet ? 52 : 48,
                  height: isTablet ? 52 : 48,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(isTablet ? 16 : 14),
                  ),
                  child: Icon(
                    icon,
                    color: cs.onPrimaryContainer,
                    size: isTablet ? 28 : 24,
                  ),
                ),
                SizedBox(width: isTablet ? 20 : 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: isTablet ? 18 : 16,
                          fontWeight: FontWeight.w800,
                          color: cs.onSurface,
                          letterSpacing: -0.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: TextStyle(color: cs.onSurfaceVariant),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Abrir formulario',
                        style: TextStyle(
                          fontSize: isTablet ? 14 : 12,
                          color: cs.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: cs.onSurfaceVariant,
                  size: isTablet ? 22 : 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MaintenanceChecklistRunnerPage extends ConsumerStatefulWidget {
  final GerenciaTheme theme;
  final ChecklistReportDefinition definition;
  final String userName;
  final String userArea;

  const MaintenanceChecklistRunnerPage({
    super.key,
    required this.theme,
    required this.definition,
    required this.userName,
    required this.userArea,
  });

  @override
  ConsumerState<MaintenanceChecklistRunnerPage> createState() =>
      _MaintenanceChecklistRunnerPageState();
}

class _MaintenanceChecklistRunnerPageState
    extends ConsumerState<MaintenanceChecklistRunnerPage> {
  var _generating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GerenciaAppBar(
        theme: widget.theme,
        title: widget.definition.title,
      ),
      body: Stack(
        children: [
          ChecklistReportForm(
            definition: widget.definition,
            onSubmit: _onSubmit,
          ),
          if (_generating)
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

  Future<void> _onSubmit(ChecklistReportDraft draft) async {
    if (_generating) return;
    setState(() => _generating = true);

    try {
      final bytes = await MaintenancePreventivoPdf.build(
        definition: widget.definition,
        draft: draft,
      );

      final safeId = draft.reportTypeId.replaceAll(
        RegExp(r'[^a-zA-Z0-9_-]'),
        '',
      );
      final filename =
          'reporte_${safeId}_${DateTime.now().millisecondsSinceEpoch}.pdf';

      final file = await PdfFileService.saveToDocuments(
        bytes: bytes,
        filename: filename,
      );

      final user = ref.read(authControllerProvider).user;
      await ref
          .read(generatedPdfRepositoryProvider)
          .add(
            GeneratedPdf(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              filename: filename,
              localPath: file.path,
              createdAt: DateTime.now(),
              createdByUserId: user?.id ?? '',
              createdByName: user?.nombre ?? '',
              area: user?.area ?? '',
              gerenciaId: user?.resolvedGerenciaId,
              source: 'reporte',
            ),
          );
      ref.invalidate(generatedPdfsProvider);

      await PdfFileService.openFile(file);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('No se pudo generar PDF: $e')));
    } finally {
      if (mounted) setState(() => _generating = false);
    }
  }
}

class EtpChecklistRunnerPage extends ConsumerStatefulWidget {
  final GerenciaTheme theme;
  final EtpChecklistDefinition definition;
  final String userName;
  final String checklistName;

  const EtpChecklistRunnerPage({
    super.key,
    required this.theme,
    required this.definition,
    required this.userName,
    required this.checklistName,
  });

  @override
  ConsumerState<EtpChecklistRunnerPage> createState() =>
      _EtpChecklistRunnerPageState();
}

class _EtpChecklistRunnerPageState
    extends ConsumerState<EtpChecklistRunnerPage> {
  var _generating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GerenciaAppBar(
        theme: widget.theme,
        title: widget.definition.title,
      ),
      body: Stack(
        children: [
          EtpChecklistForm(
            definition: widget.definition,
            userName: widget.userName,
            checklistName: widget.checklistName,
            onSubmit: _onSubmit,
          ),
          if (_generating)
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

  Future<void> _onSubmit(EtpChecklistDraft draft) async {
    if (_generating) return;
    setState(() => _generating = true);

    try {
      final bytes = await EtpChecklistPdf.build(
        definition: widget.definition,
        draft: draft,
      );

      final safeId = draft.reportTypeId.replaceAll(
        RegExp(r'[^a-zA-Z0-9_-]'),
        '',
      );
      final filename =
          'checklist_${safeId}_${DateTime.now().millisecondsSinceEpoch}.pdf';

      final file = await PdfFileService.saveToDocuments(
        bytes: bytes,
        filename: filename,
      );

      final user = ref.read(authControllerProvider).user;
      await ref
          .read(generatedPdfRepositoryProvider)
          .add(
            GeneratedPdf(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              filename: filename,
              localPath: file.path,
              createdAt: DateTime.now(),
              createdByUserId: user?.id ?? '',
              createdByName: user?.nombre ?? '',
              area: user?.area ?? '',
              gerenciaId: user?.resolvedGerenciaId,
              source: 'reporte',
            ),
          );
      ref.invalidate(generatedPdfsProvider);

      // Crear tarea automáticamente por checklist generado.
      if (user != null && user.id.trim().isNotEmpty) {
        final tarea = Tarea(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          reporteId: 'checklist:$safeId',
          titulo: filename,
          descripcion: filename,
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
      if (mounted) setState(() => _generating = false);
    }
  }
}
