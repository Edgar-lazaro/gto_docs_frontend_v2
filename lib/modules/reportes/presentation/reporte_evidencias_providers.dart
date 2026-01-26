import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';

import '../../../core/database/database_providers.dart';
import '../data/reporte_evidencias_repository_impl.dart';
import '../domain/reporte_evidencia.dart';

final reporteEvidenciasRepositoryProvider =
    Provider<ReporteEvidenciasRepository>((ref) {
  return ReporteEvidenciasRepository(
    ref.read(appDatabaseProvider),
  );
});

final evidenciasPorReporteProvider = FutureProvider.family<List<ReporteEvidencia>, String>((ref, reporteId) async {
  final db = ref.read(appDatabaseProvider);
  final rows = await (db.select(db.reporteEvidenciasTable)
        ..where((e) => e.reporteId.equals(reporteId))
        ..orderBy([(e) => OrderingTerm.desc(e.creadoEn)]))
      .get();

  return rows
      .map(
        (e) => ReporteEvidencia(
          id: e.id,
          reporteId: e.reporteId,
          tipo: EvidenciaTipo.values.byName(e.tipo),
          nombre: e.nombre,
          localPath: e.localPath,
          remoteUrl: e.remoteUrl,
          creadoEn: e.creadoEn,
        ),
      )
      .toList();
});