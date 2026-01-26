import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../domain/reporte.dart';
import '../domain/reporte_evidencia.dart';
import 'reporte_providers.dart';
import 'reporte_evidencias_providers.dart';

class ReporteDetallePage extends ConsumerWidget {
  final String reporteId;

  const ReporteDetallePage({super.key, required this.reporteId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reporteAsync = ref.watch(reportePorIdProvider(reporteId));
    final evidenciasAsync =
        ref.watch(evidenciasPorReporteProvider(reporteId));

    return reporteAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(body: Text('Error: $e')),
      data: (reporte) {
        return Scaffold(
          appBar: AppBar(title: Text(reporte.titulo)),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info básica
                Text(reporte.descripcion),
                const SizedBox(height: 12),
                Text('Área: ${reporte.area}'),
                Text('Estado: ${reporte.estado.asString}'),
                if (reporte.glpiTicketId != null)
                  Text('Ticket GLPI: ${reporte.glpiTicketId}'),

                const SizedBox(height: 16),

                // Agregar evidencia
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () async {
                    final picker = ImagePicker();
                    final file = await picker.pickImage(
                      source: ImageSource.camera,
                    );

                    if (file == null) return;

                    await ref
                        .read(reporteEvidenciasRepositoryProvider)
                        .agregarEvidencia(
                          reporteId: reporte.id,
                          tipo: EvidenciaTipo.imagen,
                          nombre: file.name,
                          localPath: file.path,
                        );
                  },
                ),

                const SizedBox(height: 16),

                // Evidencias (reactivo)
                Expanded(
                  child: evidenciasAsync.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Text('Error: $e'),
                    data: (evidencias) {
                      if (evidencias.isEmpty) {
                        return const Text('Sin evidencias');
                      }

                      return Wrap(
                        spacing: 8,
                        children: evidencias.map((e) {
                          return Image.file(
                            File(e.localPath),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}