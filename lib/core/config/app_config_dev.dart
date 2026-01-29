import 'app_config.dart';
import 'env.dart'; // donde esté definido AppEnv

const devConfig = AppConfig(
  env: AppEnv.dev,

  // Red / LAN
  allowedIpRanges: [
    '192.168.1.72/24',
  ],

  // Backend
  apiBaseUrl: '192.168.1.72',
  apiPort: 3000,
  useHttps: false,

  // Auth
  authEndpoint: '/auth/login',
  useJwt: true,

  // GLPI
  glpiBaseUrl: 'http://192.168.1.72/glpi',
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