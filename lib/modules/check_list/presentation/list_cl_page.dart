import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/ui/theme/gerencia_config.dart';
import '../../../shared/ui/widgets/gerencia_app_bar.dart';
import '../domain/checklist_existente.dart';
import 'check_list_providers.dart';
import 'checklist_runner_page.dart';

class ListClPage extends ConsumerWidget {
  final GerenciaTheme theme;
  final int jefaturaId;
  final String jefaturaNombre;

  const ListClPage({
    super.key,
    required this.theme,
    required this.jefaturaId,
    required this.jefaturaNombre,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final width = MediaQuery.of(context).size.width;
    final horizontalPadding = width >= 1200
        ? 120.0
        : width >= 900
        ? 80.0
        : width >= 600
        ? 60.0
        : 24.0;

    final clAsync = ref.watch(clExistentesPorJefaturaProvider(jefaturaId));

    return Scaffold(
      appBar: GerenciaAppBar(theme: theme, title: 'CL de $jefaturaNombre'),
      body: clAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 32 : 24),
            child: Text('Error al cargar checklist: ${_errorMsg(e)}'),
          ),
        ),
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text('No hay checklist registrados para esta jefatura'),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(clExistentesPorJefaturaProvider(jefaturaId));
              await ref.read(
                clExistentesPorJefaturaProvider(jefaturaId).future,
              );
            },
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isTablet ? 32 : 24,
              ),
              itemCount: items.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: isTablet ? 20 : 16),
              itemBuilder: (context, index) {
                final cl = items[index];
                return _ChecklistCard(
                  cl: cl,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChecklistRunnerPage(
                          theme: theme,
                          jefaturaId: jefaturaId,
                          jefaturaNombre: jefaturaNombre,
                          checklist: cl,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _ChecklistCard extends StatelessWidget {
  final ChecklistExistente cl;
  final VoidCallback onTap;

  const _ChecklistCard({required this.cl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final cs = Theme.of(context).colorScheme;

    IconData icon;
    final name = cl.nombre.toLowerCase();
    if (name.contains('red') || name.contains('wifi')) {
      icon = Icons.wifi;
    } else if (name.contains('impres')) {
      icon = Icons.print;
    } else if (name.contains('pc') || name.contains('comput')) {
      icon = Icons.computer;
    } else {
      icon = Icons.document_scanner;
    }

    return Card(
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
                  width: isTablet ? 56 : 48,
                  height: isTablet ? 56 : 48,
                  decoration: BoxDecoration(
                    color: cs.primary.withAlpha(18),
                    borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                  ),
                  child: Icon(
                    icon,
                    color: cs.primary,
                    size: isTablet ? 30 : 26,
                  ),
                ),
                SizedBox(width: isTablet ? 20 : 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cl.nombre,
                        style: TextStyle(
                          fontSize: isTablet ? 18 : 16,
                          fontWeight: FontWeight.bold,
                          color: cs.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Abrir checklist',
                        style: TextStyle(
                          fontSize: isTablet ? 14 : 12,
                          color: cs.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: cs.onSurfaceVariant,
                  size: isTablet ? 24 : 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _errorMsg(Object e) {
  if (e is StateError) return e.message;
  return e.toString();
}
