import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import '../data/asistencia_repository_impl.dart';
import '../domain/asistencia_repository.dart';
import 'asistencia_controller.dart';

final asistenciaRepositoryProvider =
    Provider<AsistenciaRepository>((ref) {
  return AsistenciaRepositoryImpl(
    ref.read(appDatabaseProvider),
  );
});

final asistenciaControllerProvider = StateNotifierProvider<
    AsistenciaController, AsistenciaState>((ref) {
  return AsistenciaController(
    ref.read(asistenciaRepositoryProvider),
    ref,
  );
});