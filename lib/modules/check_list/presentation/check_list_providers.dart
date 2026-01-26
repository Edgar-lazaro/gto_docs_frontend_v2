import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_providers.dart';
import '../../../core/auth/role_utils.dart';
import '../../../core/network/providers.dart';
import '../data/check_list_api_repository.dart';
import '../domain/checklist_existente.dart';
import '../domain/jefatura.dart';

final checkListRepositoryProvider = Provider<CheckListApiRepository>((ref) {
  return CheckListApiRepository(dio: ref.read(dioProvider));
});

final jefaturasProvider = FutureProvider<List<Jefatura>>((ref) async {
  final auth = ref.watch(authControllerProvider);
  final user = auth.user;

  final gerenciaId = user?.resolvedGerenciaId;

  return ref
      .read(checkListRepositoryProvider)
      .obtenerJefaturas(gerenciaId: gerenciaId);
});

final clExistentesPorJefaturaProvider =
    FutureProvider.family<List<ChecklistExistente>, int>((
      ref,
      jefaturaId,
    ) async {
      final auth = ref.watch(authControllerProvider);
      final user = auth.user;

      final gerenciaId = user?.resolvedGerenciaId;

      return ref
          .read(checkListRepositoryProvider)
          .obtenerClExistentes(jefaturaId: jefaturaId, gerenciaId: gerenciaId);
    });
