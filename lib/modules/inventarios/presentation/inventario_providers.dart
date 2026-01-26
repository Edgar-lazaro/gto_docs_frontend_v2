import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_providers.dart';
import '../../../core/auth/role_utils.dart';
import '../../../core/network/providers.dart';
import '../data/inventario_api_repository.dart';
import '../domain/activo.dart';

final inventarioRepositoryProvider = Provider<InventarioApiRepository>((ref) {
  return InventarioApiRepository(dio: ref.read(dioProvider));
});

final inventarioItemsProvider = FutureProvider<List<Activo>>((ref) async {
  final auth = ref.watch(authControllerProvider);
  final user = auth.user;

  final gerenciaId = user?.resolvedGerenciaId;

  return ref
      .read(inventarioRepositoryProvider)
      .obtenerInventario(gerenciaId: gerenciaId);
});
