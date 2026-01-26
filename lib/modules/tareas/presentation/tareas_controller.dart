import '../../notificacions/data/notificacion_repository_impl.dart';
import '../../notificacions/domain/notificacion.dart';
import '../domain/tarea.dart';
import '../domain/tarea_repository.dart';

class TareaController {
  final TareaRepository repository;
  final NotificacionRepository notificacionRepo;

  TareaController(this.repository, this.notificacionRepo);

  Future<void> crearTarea(Tarea tarea) async {
    await repository.crearTarea(tarea);

    // NOTIFICACIÓN
    await notificacionRepo.crear(
      tipo: NotificacionTipo.tarea.name,
      titulo: 'Nueva tarea asignada',
      mensaje: tarea.titulo,
      referenciaId: tarea.id,
    );
  }
}
