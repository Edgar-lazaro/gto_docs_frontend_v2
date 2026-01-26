import '../../../core/database/app_database.dart';
import '../domain/dashboard_metrics.dart';

class DashboardRepository {
  final AppDatabase db;

  DashboardRepository(this.db);

  Future<DashboardMetrics> obtenerMetricas() async {
    final reportes = await db.select(db.reportesTable).get();
    final tareas = await db.select(db.tareasTable).get();
    final evidencias = await db.select(db.reporteEvidenciasTable).get();

    final now = DateTime.now();

    return DashboardMetrics(
      reportesAbiertos:
          reportes.where((r) => r.estado != 'resuelto').length,
      reportesCerrados:
          reportes.where((r) => r.estado == 'resuelto').length,
      tareasPendientes:
          tareas.where((t) => t.estado != 'completada').length,
      incidenciasCriticas: 0,
      evidenciasHoy: evidencias
          .where(
            (e) =>
                e.creadoEn.year == now.year &&
                e.creadoEn.month == now.month &&
                e.creadoEn.day == now.day,
          )
          .length,
    );
  }
}