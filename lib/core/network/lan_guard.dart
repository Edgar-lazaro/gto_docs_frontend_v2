import 'lan_status.dart';
import 'network_checker.dart';
import 'server_probe.dart';

class LanGuard {
  final NetworkChecker networkChecker;
  final ServerProbe serverProbe;
  final String healthUrl;
  final bool enforceLanOnly;

  LanGuard({
    required this.networkChecker,
    required this.serverProbe,
    required this.healthUrl,
    required this.enforceLanOnly,
  });

  Future<LanStatus> check() async {
    // ¿Hay red?
    final hasNetwork = await networkChecker.hasNetwork();
    if (!hasNetwork) {
      return LanStatus.disconnected;
    }
    // ¿Servidor interno responde?
    var serverOk = await serverProbe.ping(healthUrl);
    if (!serverOk) {
      // Compatibilidad: algunos backends exponen /health fuera de /api.
      if (healthUrl.endsWith('/api/health')) {
        final fallback = healthUrl.replaceFirst('/api/health', '/health');
        serverOk = await serverProbe.ping(fallback);
      } else if (healthUrl.endsWith('/health')) {
        final fallback = healthUrl.replaceFirst('/health', '/api/health');
        serverOk = await serverProbe.ping(fallback);
      }
    }
    if (!serverOk) {
      return LanStatus.serverDown;
    }

    // OK
    return LanStatus.connected;
  }
}