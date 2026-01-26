import 'package:gto_docs_v2_ad/core/config/app_config.dart';

class ApiClient {
  final AppConfig config;

  ApiClient(this.config);

  String get baseUrl =>
      '${config.useHttps ? 'https' : 'http'}://${config.apiBaseUrl}:${config.apiPort}';
}