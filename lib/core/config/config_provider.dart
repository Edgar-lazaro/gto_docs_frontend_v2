import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_config.dart';
import 'app_environment.dart';
import 'app_config_dev.dart';
import 'app_config_qa.dart';
import 'app_config_prod.dart';

const _currentEnv = AppEnvironment.dev;

final appConfigProvider = Provider<AppConfig>((ref) {
  switch (_currentEnv) {
    case AppEnvironment.dev:
      return devConfig;
    case AppEnvironment.qa:
      return qaConfig;
    case AppEnvironment.prod:
      return prodConfig;
  }
});