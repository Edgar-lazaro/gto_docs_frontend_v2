import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import '../data/dashboard_repository_impl.dart';
import '../domain/dashboard_metrics.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository(ref.read(appDatabaseProvider));
});

final dashboardMetricsProvider = FutureProvider<DashboardMetrics>((ref) async {
  return ref.read(dashboardRepositoryProvider).obtenerMetricas();
});