import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/config_provider.dart';
import '../auth/session_manager.dart';
import 'lan_guard.dart';
import 'network_checker.dart';
import 'server_probe.dart';

/// HTTP client
final dioProvider = Provider<Dio>((ref) {
  final config = ref.read(appConfigProvider);

  final protocol = config.useHttps ? 'https' : 'http';
  final baseUrl =
      '$protocol://${config.apiBaseUrl}:${config.apiPort}/api';

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        logPrint: (o) => debugPrint(o.toString()),
      ),
    );
  }

  if (config.useJwt) {
    final session = SessionManager();
    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await session.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );
  }

  return dio;
});

/// Network checker
final networkCheckerProvider =
    Provider<NetworkChecker>((ref) {
  return NetworkChecker();
});

/// Server probe
final serverProbeProvider =
    Provider<ServerProbe>((ref) {
  return ServerProbe();
});

/// LAN Guard
final lanGuardProvider = Provider<LanGuard>((ref) {
  final config = ref.read(appConfigProvider);

  final protocol = config.useHttps ? 'https' : 'http';
  final healthUrl =
      '$protocol://${config.apiBaseUrl}:${config.apiPort}/api/health';

  return LanGuard(
    networkChecker: ref.read(networkCheckerProvider),
    serverProbe: ref.read(serverProbeProvider),
    healthUrl: healthUrl,
    enforceLanOnly: true,
  );
});