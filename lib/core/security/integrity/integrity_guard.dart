import 'dart:io';

import 'package:gto_docs_v2_ad/core/security/anti_tamper/anti_tamper_guard.dart';

/// Verifica la integridad básica de la app.
/// Si falla, la app NO debe continuar.
class IntegrityGuard {
  static Future<bool> verify() async {
    final antiTamperOk = await AntiTamperGuard.verify();
    if (!antiTamperOk) return false;

    // En debug, esta verificación no debe bloquear por sí sola.
    // El guard decide cuándo aplicar hardening (release).
    if (_isDebug()) return true;

    // Bloquear emuladores básicos
    if (await _isEmulator()) return false;

    // Bloquear hooking simple
    if (_hasSuspiciousLibraries()) return false;

    return true;
  }

  static bool _isDebug() {
    bool debug = false;
    assert(() {
      debug = true;
      return true;
    }());
    return debug;
  }

  static Future<bool> _isEmulator() async {
    if (!Platform.isAndroid) return false;

    final androidProps = [
      'generic',
      'emulator',
      'sdk',
      'x86',
      'goldfish',
    ];

    final fingerprint =
        Platform.environment['ANDROID_BUILD_FINGERPRINT'] ?? '';

    return androidProps.any(
      (p) => fingerprint.toLowerCase().contains(p),
    );
  }

  static bool _hasSuspiciousLibraries() {
    final suspicious = [
      'frida',
      'substrate',
      'xposed',
    ];

    for (final lib in suspicious) {
      if (Platform.environment.keys
          .any((k) => k.toLowerCase().contains(lib))) {
        return true;
      }
    }
    return false;
  }
}