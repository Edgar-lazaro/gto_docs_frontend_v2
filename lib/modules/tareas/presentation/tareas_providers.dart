import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import '../../notificacions/presentation/notificacion_providers.dart';
import '../data/tarea_adjuntos_repository_impl.dart';
import '../data/tarea_comentarios_repository_impl.dart';
import '../data/tarea_repository_impl.dart';
import '../domain/tarea_adjunto.dart';
import '../domain/tarea_comentario.dart';
import '../domain/tarea.dart';
import '../domain/tarea_repository.dart';
import 'tareas_controller.dart';

final tareaRepositoryProvider = Provider<TareaRepository>((ref) {
  return TareaRepositoryImpl(ref.read(appDatabaseProvider));
});

final tareaControllerProvider = Provider<TareaController>((ref) {
  return TareaController(
    ref.read(tareaRepositoryProvider),
    ref.read(notificacionRepositoryProvider),
  );
});

final tareaComentariosRepositoryProvider = Provider<TareaComentariosRepository>(
  (ref) {
    return TareaComentariosRepository(ref.read(appDatabaseProvider));
  },
);

final tareaAdjuntosRepositoryProvider = Provider<TareaAdjuntosRepository>((
  ref,
) {
  return TareaAdjuntosRepository(ref.read(appDatabaseProvider));
});

final tareaComentariosProvider =
    StreamProvider.family<List<TareaComentario>, String>((ref, tareaId) {
      return ref
          .read(tareaComentariosRepositoryProvider)
          .watchPorTareaId(tareaId);
    });

final tareaAdjuntosProvider = StreamProvider.family<List<TareaAdjunto>, String>(
  (ref, tareaId) {
    return ref.read(tareaAdjuntosRepositoryProvider).watchPorTareaId(tareaId);
  },
);

final tareasPorAsignadoProvider = FutureProvider.family<List<Tarea>, String>((
  ref,
  asignadoA,
) {
  return ref.read(tareaRepositoryProvider).obtenerPorAsignado(asignadoA);
});

final tareasPorCreadorProvider = FutureProvider.family<List<Tarea>, String>((
  ref,
  creadoPor,
) {
  return ref.read(tareaRepositoryProvider).obtenerPorCreador(creadoPor);
});

final todasLasTareasProvider = FutureProvider<List<Tarea>>((ref) {
  return ref.read(tareaRepositoryProvider).obtenerTodas();
});
