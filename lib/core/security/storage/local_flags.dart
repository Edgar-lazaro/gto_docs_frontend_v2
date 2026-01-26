import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../kill_switch/kill_switch_models.dart';

class LocalFlags {
  static const _storage = FlutterSecureStorage();

  static const _disabledKey = '__app_disabled__';
  static const _reasonKey = '__app_disabled_reason__';
  static const _timestampKey = '__app_disabled_at__';

  /// Bloquea la app de forma persistente
  static Future<void> blockApp({
    required AppBlockReason reason,
  }) async {
    await _storage.write(key: _disabledKey, value: 'true');
    await _storage.write(key: _reasonKey, value: reason.name);
    await _storage.write(
      key: _timestampKey,
      value: DateTime.now().toIso8601String(),
    );
  }

  /// ¿La app está bloqueada?
  static Future<bool> isAppDisabled() async {
    final v = await _storage.read(key: _disabledKey);
    return v == 'true';
  }

  /// Motivo del bloqueo (si existe)
  static Future<AppBlockReason?> getReason() async {
    final r = await _storage.read(key: _reasonKey);
    if (r == null) return null;
    return AppBlockReason.values.byName(r);
  }

  /// SOLO PARA DEV / DEBUG CONTROLADO
  static Future<void> clear() async {
    await _storage.delete(key: _disabledKey);
    await _storage.delete(key: _reasonKey);
    await _storage.delete(key: _timestampKey);
  }
}