import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_models.dart';
import '../../../core/auth/auth_providers.dart';
import '../../../shared/ui/theme/gerencia_config.dart';
import '../../../shared/ui/widgets/gerencia_app_bar.dart';
import '../domain/jefatura.dart';
import 'check_list_providers.dart';
import 'list_cl_page.dart';

class JefaturasListPage extends ConsumerStatefulWidget {
  final GerenciaTheme theme;

  const JefaturasListPage({super.key, required this.theme});

  @override
  ConsumerState<JefaturasListPage> createState() => _JefaturasListPageState();
}

class _JefaturasListPageState extends ConsumerState<JefaturasListPage> {
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
    if (auth.status != AuthStatus.authenticated || auth.user == null) {
      return const Scaffold(body: Center(child: Text('Debes iniciar sesión')));
    }

    final jefaturasAsync = ref.watch(jefaturasProvider);

    return Scaffold(
      appBar: GerenciaAppBar(theme: widget.theme, title: 'Checklist'),
      body: jefaturasAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 32 : 24),
            child: Text('Error al cargar jefaturas: ${_errorMsg(e)}'),
          ),
        ),
        data: (items) {
          final filtered = _applySearch(items);

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(jefaturasProvider);
              await ref.read(jefaturasProvider.future);
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
                  decoration: InputDecoration(
                    hintText: 'Buscar jefatura…',
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
                SizedBox(height: isTablet ? 24 : 16),
                if (items.isEmpty)
                  const Center(child: Text('No hay jefaturas disponibles')),
                ...filtered.map(
                  (j) => _JefaturaCard(
                    jefatura: j,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ListClPage(
                            theme: widget.theme,
                            jefaturaId: j.id,
                            jefaturaNombre: j.nombre,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Jefatura> _applySearch(List<Jefatura> items) {
    final q = _searchQuery.trim().toLowerCase();
    if (q.isEmpty) return items;
    return items.where((j) => j.nombre.toLowerCase().contains(q)).toList();
  }

  String _errorMsg(Object e) {
    if (e is StateError) return e.message;
    return e.toString();
  }
}

class _JefaturaCard extends StatelessWidget {
  final Jefatura jefatura;
  final VoidCallback onTap;

  const _JefaturaCard({required this.jefatura, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;

    final cs = Theme.of(context).colorScheme;

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
                _JefaturaAvatar(img: jefatura.img),
                SizedBox(width: isTablet ? 20 : 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jefatura.nombre,
                        style: TextStyle(
                          fontSize: isTablet ? 20 : 16,
                          fontWeight: FontWeight.bold,
                          color: cs.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ver checklist',
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

class _JefaturaAvatar extends StatelessWidget {
  final String? img;

  const _JefaturaAvatar({required this.img});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;

    final name = img?.trim();
    if (name == null || name.isEmpty) {
      return _fallback(isTablet);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
      child: Image.asset(
        'assets/img/$name.png',
        width: isTablet ? 80 : 64,
        height: isTablet ? 80 : 64,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _fallback(isTablet),
      ),
    );
  }

  Widget _fallback(bool isTablet) {
    return Container(
      width: isTablet ? 80 : 64,
      height: isTablet ? 80 : 64,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
      ),
      child: Icon(
        Icons.business,
        color: Colors.blue[700],
        size: isTablet ? 40 : 32,
      ),
    );
  }
}
