import 'dart:io';

import 'package:flutter/foundation.dart';

class ServerProbe {
  final Map<String, int> _lastLoggedStatusByUrl = <String, int>{};
  final Map<String, DateTime> _lastLoggedErrorAtByUrl = <String, DateTime>{};

  Future<bool> ping(String url) async {
    final client = HttpClient();
    client.connectionTimeout = const Duration(seconds: 3);

    try {
      final request = await client.getUrl(Uri.parse(url));
      final response = await request.close();

      if (kDebugMode) {
        final last = _lastLoggedStatusByUrl[url];
        if (last == null || last != response.statusCode) {
          _lastLoggedStatusByUrl[url] = response.statusCode;
          debugPrint('ServerProbe.ping $url -> ${response.statusCode}');
        }
      }

      // Para detección de conectividad LAN, basta con recibir cualquier respuesta HTTP: 401/404 también implica que el servidor está vivo.
      return response.statusCode >= 100 && response.statusCode < 600;
    } catch (e) {
      if (kDebugMode) {
        final now = DateTime.now();
        final lastAt = _lastLoggedErrorAtByUrl[url];
        // Throttle error logs per-URL (e.g., server down) to avoid console spam.
        if (lastAt == null ||
            now.difference(lastAt) >= const Duration(seconds: 30)) {
          _lastLoggedErrorAtByUrl[url] = now;
          debugPrint('ServerProbe.ping $url failed: $e');
        }
      }
      return false;
    } finally {
      client.close(force: true);
    }
  }
}
