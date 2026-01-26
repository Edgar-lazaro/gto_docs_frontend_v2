import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import '../../../core/network/providers.dart';
import '../../notificacions/presentation/notificacion_providers.dart';
import '../data/reporte_repository_impl.dart';
import '../domain/reporte.dart';
import '../domain/reporte_repository.dart';
import 'reporte_controller.dart';

final reporteRepositoryProvider = Provider<ReporteRepository>((ref) {
  return ReporteRepositoryImpl(
    db: ref.read(appDatabaseProvider),
    dio: ref.read(dioProvider),
  );
});

final reporteControllerProvider =
    StateNotifierProvider<ReporteController, AsyncValue<List<Reporte>>>(
      (ref) => ReporteController(
        ref.read(reporteRepositoryProvider),
        ref.read(notificacionRepositoryProvider),
      ),
    );

final reportePorIdProvider = FutureProvider.family<Reporte, String>((
  ref,
  id,
) async {
  final repo = ref.read(reporteRepositoryProvider);
  final all = await repo.obtenerReportes();
  return all.firstWhere((r) => r.id == id);
});
