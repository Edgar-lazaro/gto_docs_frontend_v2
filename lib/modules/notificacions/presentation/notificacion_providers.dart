import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gto_docs_v2_ad/modules/notificacions/domain/notificacion.dart';
import '../../../core/database/database_providers.dart';
import '../data/notificacion_repository_impl.dart';

final notificacionRepositoryProvider =
    Provider<NotificacionRepository>((ref) {
  return NotificacionRepository(
    ref.read(appDatabaseProvider),
  );
});

final notificacionesProvider =
    FutureProvider<List<Notificacion>>((ref) {
  return ref
      .read(notificacionRepositoryProvider)
      .obtenerTodas();
});

final notificacionesNoLeidasCountProvider =
    StreamProvider<int>((ref) {
  return ref
      .read(notificacionRepositoryProvider)
      .watchNoLeidas();
});


