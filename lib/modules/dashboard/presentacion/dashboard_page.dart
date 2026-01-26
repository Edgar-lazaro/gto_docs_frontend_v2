import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dashboard_providers.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metrics = ref.watch(dashboardMetricsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: metrics.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => Text('Error: $e'),
        data: (m) => Column(
          children: [
            _tile('Reportes abiertos', m.reportesAbiertos),
            _tile('Reportes cerrados', m.reportesCerrados),
            _tile('Tareas pendientes', m.tareasPendientes),
            _tile('Evidencias hoy', m.evidenciasHoy),
          ],
        ),
      ),
    );
  }

  Widget _tile(String label, int value) {
    return Card(
      child: ListTile(
        title: Text(label),
        trailing: Text('$value'),
      ),
    );
  }
}