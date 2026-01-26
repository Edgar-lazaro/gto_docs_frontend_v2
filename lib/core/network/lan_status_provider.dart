import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'lan_status.dart';
import 'providers.dart';

final lanStatusProvider = StreamProvider<LanStatus>((ref) async* {
  final guard = ref.read(lanGuardProvider);

  yield LanStatus.checking;

  LanStatus? lastEmitted;
  var delay = const Duration(seconds: 5);

  while (true) {
    final status = await guard.check();

    if (status != lastEmitted) {
      lastEmitted = status;
      yield status;
    }

    // Backoff when the server is down to avoid aggressive pings/log spam.
    if (status == LanStatus.connected) {
      delay = const Duration(seconds: 5);
    } else if (status == LanStatus.serverDown) {
      final nextSeconds = (delay.inSeconds * 2).clamp(5, 60);
      delay = Duration(seconds: nextSeconds);
    } else if (status == LanStatus.disconnected) {
      delay = const Duration(seconds: 15);
    } else {
      delay = const Duration(seconds: 5);
    }

    await Future.delayed(delay);
  }
});
