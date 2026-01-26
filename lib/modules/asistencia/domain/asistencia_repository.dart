import 'asistencia.dart';

abstract class AsistenciaRepository {
  Future<void> registrar({
    required String usuarioId,
    required TipoAsistencia tipo,
    required String metodo,
  });

  Future<List<Asistencia>> obtenerHistorial(String usuarioId);
}