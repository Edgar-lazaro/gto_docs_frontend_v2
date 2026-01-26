import 'kill_switch_models.dart';
import '../storage/local_flags.dart';

/// Servicio central del Kill Switch
/// Decide si la app puede ejecutarse o no
class KillSwitchService {
  const KillSwitchService();

  /// Flujo:
  /// 1) Revisa si ya está bloqueada localmente
  /// 2) (Opcional futuro) revisa flags remotos / LAN
  Future<KillSwitchStatus> check({
    required bool hasLan,
  }) async {
    // Bloqueo persistente local (offline-safe)
    final disabled = await LocalFlags.isAppDisabled();
    if (disabled) {
      final reason = await LocalFlags.getReason();
      return KillSwitchStatus.blocked(
        reason ?? AppBlockReason.manualDeveloperBlock,
      );
    }

    return KillSwitchStatus.active();
  }
}
