import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gto_docs_v2_ad/core/network/providers.dart';
import 'package:gto_docs_v2_ad/modules/notificacions/presentation/notificacion_providers.dart';

import '../database/database_providers.dart';
import '../network/lan_status.dart';
import '../network/lan_status_provider.dart';
import 'sync_service.dart';
import 'sync_worker.dart';

/// Servicio de sincronización
final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(
    db: ref.read(appDatabaseProvider),
    dio: ref.read(dioProvider),
  );
});

/// Worker de sincronización
final syncWorkerProvider = Provider<SyncWorker>((ref) {
  return SyncWorker(
    db: ref.read(appDatabaseProvider),
    service: ref.read(syncServiceProvider),
    notificacionRepo: ref.read(notificacionRepositoryProvider),
  );
});

/// Listener global (se ejecuta automáticamente)
final syncListenerProvider = Provider<void>((ref) {
  Timer? timer;
  LanStatus? lastStatus;

  ref.onDispose(() {
    timer?.cancel();
  });

  void ensureTimerRunning() {
    timer ??= Timer.periodic(
      const Duration(seconds: 10),
      (_) => ref.read(syncWorkerProvider).run(LanStatus.connected),
    );
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
  }

  ref.listen<AsyncValue<LanStatus>>(lanStatusProvider, (prev, next) {
    next.whenData((status) {
      if (status == lastStatus) return;
      lastStatus = status;

      if (status == LanStatus.connected) {
        
        ref.read(syncWorkerProvider).run(status);
        ensureTimerRunning();
        return;
      }

      stopTimer();
    });
  });
});
