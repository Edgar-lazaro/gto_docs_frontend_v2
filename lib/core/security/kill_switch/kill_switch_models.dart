/// Motivos por los cuales la aplicación puede ser deshabilitada
/// Importante: estos valores se usan para auditoría y mensajes
enum AppBlockReason {
  /// Bloqueo manual ejecutado por el desarrollador (kill switch)
  manualDeveloperBlock,

  /// Riesgo de seguridad (debug, tamper, integridad)
  securityRisk,

  /// Incumplimiento operativo o administrativo
  contractViolation,
}


class KillSwitchStatus {
  final bool blocked;
  final AppBlockReason? reason;

  const KillSwitchStatus({
    required this.blocked,
    this.reason,
  });

  factory KillSwitchStatus.active() {
    return const KillSwitchStatus(blocked: false);
  }

  factory KillSwitchStatus.blocked(AppBlockReason reason) {
    return KillSwitchStatus(
      blocked: true,
      reason: reason,
    );
  }
}