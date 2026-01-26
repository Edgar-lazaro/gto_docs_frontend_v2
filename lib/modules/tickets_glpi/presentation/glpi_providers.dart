import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import '../data/glpi_repository_impl.dart';
import '../domain/glpi_repository.dart';

final glpiRepositoryProvider = Provider<GlpiRepository>((ref) {
  return GlpiRepositoryImpl(
    db: ref.read(appDatabaseProvider),
  );
});