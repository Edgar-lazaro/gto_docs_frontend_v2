import 'tarea.dart';

abstract class TareaRepository {
  Future<void> crearTarea(Tarea tarea);

  Future<void> actualizarEstado({
    required String tareaId,
    required TareaEstado estado,
  });

  Future<List<Tarea>> obtenerPorAsignado(String asignadoA);

  Future<List<Tarea>> obtenerPorCreador(String creadoPor);

  Future<List<Tarea>> obtenerTodas();
}
