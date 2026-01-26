import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../notificacions/data/notificacion_repository_impl.dart';
import '../../notificacions/domain/notificacion.dart';
import '../domain/reporte.dart';
import '../domain/reporte_repository.dart';

class ReporteController extends StateNotifier<AsyncValue<List<Reporte>>> {
  final ReporteRepository repository;
  final NotificacionRepository notificacionRepo;

  ReporteController(this.repository, this.notificacionRepo)
      : super(const AsyncValue.loading()) {
    _load();
  }

  Future<void> _load() async {
    try {
      final data = await repository.obtenerReportes();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() => _load();

  Future<void> crear({
    required String titulo,
    required String descripcion,
    required String categoria,
    required String area,
    required String creadoPor,
  }) async {
    final reporte = Reporte(
      id: const Uuid().v4(),
      titulo: titulo,
      descripcion: descripcion,
      categoria: categoria,
      area: area,
      creadoPor: creadoPor,
      creadoEn: DateTime.now(),
    );

    await repository.crearReporte(reporte);

    await notificacionRepo.crear(
      tipo: NotificacionTipo.reporte.name,
      titulo: 'Reporte enviado',
      mensaje: reporte.titulo,
      referenciaId: reporte.id,
    );

    await _load();
  }
}

