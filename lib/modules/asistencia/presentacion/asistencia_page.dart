import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gto_docs_v2_ad/modules/asistencia/presentacion/asistencia_controller.dart';

import '../domain/asistencia.dart';
import 'asistencia_providers.dart';

class AsistenciaPage extends ConsumerWidget {
  final String usuarioId;

  const AsistenciaPage({
    super.key,
    required this.usuarioId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(asistenciaControllerProvider);

    ref.listen<AsistenciaState>(
      asistenciaControllerProvider,
      (prev, next) {
        if (next.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.error!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Asistencia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state.loading)
              const CircularProgressIndicator(),

            if (!state.loading) ...[
              _AsistenciaButton(
                label: 'Registrar Entrada',
                icon: Icons.login,
                color: Colors.green,
                onPressed: () {
                  ref
                      .read(asistenciaControllerProvider.notifier)
                      .registrarAsistencia(
                        usuarioId: usuarioId,
                        tipo: TipoAsistencia.entrada,
                      );
                },
              ),
              const SizedBox(height: 16),
              _AsistenciaButton(
                label: 'Registrar Salida',
                icon: Icons.logout,
                color: Colors.red,
                onPressed: () {
                  ref
                      .read(asistenciaControllerProvider.notifier)
                      .registrarAsistencia(
                        usuarioId: usuarioId,
                        tipo: TipoAsistencia.salida,
                      );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AsistenciaButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _AsistenciaButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          textStyle: const TextStyle(fontSize: 16),
        ),
        onPressed: onPressed,
      ),
    );
  }
}