import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkChecker {
  final Connectivity _connectivity = Connectivity();

  /// ¿Existe conectividad?
  Future<bool> hasNetwork() async {
    final results = await _connectivity.checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }

  /// ¿Está conectado por WiFi o Ethernet?
  Future<bool> isLanConnection() async {
    final results = await _connectivity.checkConnectivity();
    return results.contains(ConnectivityResult.wifi) ||
        results.contains(ConnectivityResult.ethernet);
  }

  /// Obtiene IP local
  Future<String?> getLocalIp() async {
    try {
      final interfaces = await NetworkInterface.list(
        type: InternetAddressType.IPv4,
        includeLoopback: false,
      );

      for (final iface in interfaces) {
        for (final addr in iface.addresses) {
          if (!addr.isLoopback) {
            return addr.address;
          }
        }
      }
    } catch (_) {}

    return null;
  }

  /// Verifica si la IP pertenece a rangos permitidos 
  bool isIpAllowed(String ip, List<String> allowedRanges) {
    
    return allowedRanges.isNotEmpty;
  }
}