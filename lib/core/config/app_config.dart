import 'package:gto_docs_v2_ad/core/config/env.dart';

class AppConfig {
  final AppEnv env;

  final List<String> allowedIpRanges;
  final String apiBaseUrl;
  final int apiPort;
  final bool useHttps;
  final String authEndpoint;
  final bool useJwt;
  final String glpiBaseUrl;
  final String glpiApiToken;
  final int glpiEntityId;
  final int maxFileSizeMb;
  final List<String> allowedFileTypes;
  final bool enableBiometrics;
  final bool enableIA;
  final bool enablePush;

  const AppConfig({
    required this.env,
    required this.allowedIpRanges,
    required this.apiBaseUrl,
    required this.apiPort,
    required this.useHttps,
    required this.authEndpoint,
    required this.useJwt,
    required this.glpiBaseUrl,
    required this.glpiApiToken,
    required this.glpiEntityId,
    required this.maxFileSizeMb,
    required this.allowedFileTypes,
    required this.enableBiometrics,
    required this.enableIA,
    required this.enablePush,
  });
}