import 'app_config.dart';
import 'env.dart'; // donde esté definido AppEnv

const prodConfig = AppConfig(
  env: AppEnv.prod,

  // Red / LAN
  allowedIpRanges: [
    'ip_ait/24',
  ],

  // Backend
  apiBaseUrl: 'ip_ait',
  apiPort: 3000,
  useHttps: false,

  // Auth
  authEndpoint: '/auth/login',
  useJwt: true,

  // GLPI
  glpiBaseUrl: 'http://ip_ait/glpi',
  glpiApiToken: 'PENDIENTE_DE_TI',
  glpiEntityId: 0,

  // Evidencias
  maxFileSizeMb: 100,
  allowedFileTypes: ['jpg', 'png', 'pdf'],

  // Features
  enableBiometrics: false,
  enableIA: false,
  enablePush: false,
);