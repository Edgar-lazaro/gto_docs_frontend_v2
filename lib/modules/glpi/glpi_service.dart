import 'package:gto_docs_v2_ad/core/config/app_config.dart';

class GlpiService {
  final AppConfig config;

  GlpiService(this.config);

  String get baseUrl => config.glpiBaseUrl;
  String get token => config.glpiApiToken;
}