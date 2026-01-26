import 'package:connectivity_plus/connectivity_plus.dart';

class LanGate {
  /// Interpretación mínima de "LAN corporativa": Wi‑Fi o Ethernet.
  static Future<bool> isOnLan() async {
    final result = await Connectivity().checkConnectivity();
    return result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.ethernet);
  }
}
