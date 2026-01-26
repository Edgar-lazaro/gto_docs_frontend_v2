import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gto_docs_v2_ad/modules/reportes/presentation/reports_builder_page.dart';
import 'dart:io';

import '../../../core/auth/auth_providers.dart';
import '../../../core/auth/auth_models.dart';
import '../../../core/auth/role_utils.dart';
import '../../../core/pdfs/generated_pdf.dart';
import '../../../core/pdfs/generated_pdf_providers.dart';
import '../../../core/reports_engine/pdf_file_service.dart';
import '../../../shared/ui/theme/gerencia_config.dart';
import '../../../shared/ui/widgets/gerencia_app_bar.dart';

class ReportesPage extends ConsumerStatefulWidget {
  final GerenciaTheme theme;

  const ReportesPage({super.key, required this.theme});

  @override
  ConsumerState<ReportesPage> createState() => _ReportesPageState();
}

class _ReportesPageState extends ConsumerState<ReportesPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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

    final auth = ref.watch(authControllerProvider);
    final user = auth.user;

    if (user == null) {
      return const Scaffold(body: Center(child: Text('Debes iniciar sesión')));
    }

    final pdfsAsync = ref.watch(generatedPdfsProvider);

    return Scaffold(
      appBar: GerenciaAppBar(
        theme: widget.theme,
        title: 'Reportes',
        actions: [
          IconButton(
            tooltip: 'Generador de reportes',
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ReportsBuilderPage(theme: widget.theme),
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Actualizar',
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(generatedPdfsProvider),
          ),
        ],
      ),
      body: pdfsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 32 : 24),
            child: Text('Error: $e'),
          ),
        ),
        data: (all) {
          final visible = _filterByRole(user, all);
          final filtered = _applySearch(visible);

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(generatedPdfsProvider);
              await ref.read(generatedPdfsProvider.future);
            },
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isTablet ? 32 : 24,
              ),
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _searchQuery = v),
                  decoration: const InputDecoration(
                    hintText: 'Buscar reporte…',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                SizedBox(height: isTablet ? 24 : 16),
                if (visible.isEmpty)
                  const Center(child: Text('No hay PDFs generados'))
                else if (filtered.isEmpty)
                  const Center(child: Text('Sin resultados para tu búsqueda')),
                ...filtered.map(
                  (p) => _PdfCard(pdf: p, onTap: () => _openPdf(context, p)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<GeneratedPdf> _applySearch(List<GeneratedPdf> items) {
    final q = _searchQuery.trim().toLowerCase();
    if (q.isEmpty) return items;
    return items.where((p) {
      final filename = p.filename.toLowerCase();
      final createdBy =
          (p.createdByName.isEmpty ? p.createdByUserId : p.createdByName)
              .toLowerCase();
      final area = p.area.toLowerCase();
      final source = p.source.toLowerCase();
      return filename.contains(q) ||
          createdBy.contains(q) ||
          area.contains(q) ||
          source.contains(q);
    }).toList();
  }

  Future<void> _openPdf(BuildContext context, GeneratedPdf p) async {
    final file = File(p.localPath);
    if (!await file.exists()) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se encontró el archivo local')),
        );
      }
      return;
    }
    await PdfFileService.openFile(file);
  }
}

class _PdfCard extends StatelessWidget {
  final GeneratedPdf pdf;
  final VoidCallback onTap;

  const _PdfCard({required this.pdf, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final cs = Theme.of(context).colorScheme;
    final label = pdf.createdByName.isEmpty
        ? pdf.createdByUserId
        : pdf.createdByName;
    final subtitle = '$label • ${pdf.area}';

    return Card(
      margin: EdgeInsets.only(bottom: isTablet ? 20 : 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(isTablet ? 20 : 16),
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 20 : 16),
            child: Row(
              children: [
                Container(
                  width: isTablet ? 52 : 48,
                  height: isTablet ? 52 : 48,
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    borderRadius: BorderRadius.circular(isTablet ? 16 : 14),
                  ),
                  child: Icon(
                    pdf.uploaded ? Icons.cloud_done : Icons.picture_as_pdf,
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
                        pdf.filename,
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
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          if (pdf.source.isNotEmpty)
                            Chip(
                              label: Text(
                                pdf.source,
                                style: const TextStyle(fontSize: 14),
                              ),
                              visualDensity: VisualDensity.compact,
                            ),
                          Chip(
                            label: Text(
                              pdf.uploaded ? 'Subido' : 'Local',
                              style: const TextStyle(fontSize: 14),
                            ),
                            visualDensity: VisualDensity.compact,
                          ),
                        ],
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

List<GeneratedPdf> _filterByRole(AuthUser user, List<GeneratedPdf> all) {
  if (user.isAdmin) return all;
  if (user.isGerente) {
    final gid = user.resolvedGerenciaId;
    if (gid == null) {
      return all.where((p) => p.createdByUserId == user.id).toList();
    }
    return all.where((p) => p.gerenciaId == gid).toList();
  }
  if (user.isJefeDepartamento) {
    final area = user.area.trim().toLowerCase();
    if (area.isEmpty) {
      return all.where((p) => p.createdByUserId == user.id).toList();
    }
    return all.where((p) => p.area.trim().toLowerCase() == area).toList();
  }
  // Auxiliar (y cualquier otro): solo propios.
  return all.where((p) => p.createdByUserId == user.id).toList();
}
