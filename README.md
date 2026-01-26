# Gto Docs V2 Ad

Proyecto Flutter.
# Gto Docs V2 Ad

Proyecto Flutter.

## Requisitos

- Flutter SDK (canal `stable`) y Dart (ver `environment:` en `pubspec.yaml`).
- macOS:
	- Xcode (para iOS) + Command Line Tools
	- CocoaPods (`pod --version`)
- Android (si aplica): Android Studio + Android SDK (incluye `adb`).

Verifica tu entorno con:

```bash
flutter doctor -v
```

## Instalación de dependencias

1) Instalar paquetes:

```bash
flutter pub get
```

2) (Solo si cambias tablas/modelos Drift o se desincroniza el código generado)

Este proyecto usa Drift y genera archivos `*.g.dart` (por ejemplo `app_database.g.dart`).

```bash
dart run build_runner build --delete-conflicting-outputs
```

3) iOS (pods)

Normalmente `flutter run` resuelve pods automáticamente, pero si Xcode falla o faltan pods:

```bash
cd ios
pod install
cd ..
```

## Configuración del servidor (API / LAN / GLPI)

El cliente HTTP arma la URL base del backend como:

`http(s)://<apiBaseUrl>:<apiPort>/api`

Dónde se configura:

- [lib/core/config/config_provider.dart](lib/core/config/config_provider.dart): cambia `_currentEnv` para seleccionar `dev`, `qa` o `prod`.
- [lib/core/config/app_config_dev.dart](lib/core/config/app_config_dev.dart), [lib/core/config/app_config_qa.dart](lib/core/config/app_config_qa.dart), [lib/core/config/app_config_prod.dart](lib/core/config/app_config_prod.dart):
	- `apiBaseUrl`, `apiPort`, `useHttps`
	- `glpiBaseUrl`, `glpiApiToken`

Nota: actualmente se usa el host `ip_ait`. Para que funcione tienes 2 opciones:

1) Reemplazar `ip_ait` por la IP o dominio real (ej. `192.168.1.74`).
2) Mantener `ip_ait` y crear un alias DNS/hosts que apunte a la IP del servidor.

### iOS: permisos/red local y HTTP

Si el backend es HTTP o está en red local, iOS puede bloquear la conexión por ATS. Revisa:

- [ios/Runner/Info.plist](ios/Runner/Info.plist): `NSLocalNetworkUsageDescription` y `NSAppTransportSecurity/NSExceptionDomains`.

El key dentro de `NSExceptionDomains` debe coincidir con el host que uses (`ip_ait`, un dominio, o una IP).

### Variables opcionales (Supabase)

Si en el futuro se habilita modo online con Supabase, los valores se inyectan con `--dart-define` (no van hardcodeados):

```bash
flutter run \
	--dart-define=SUPABASE_URL=... \
	--dart-define=SUPABASE_ANON_KEY=...
```

## Ejecutar en dispositivo físico

Lista los dispositivos conectados:

```bash
flutter devices
```

### Android (dispositivo físico)

1) En el teléfono: activa **Opciones de desarrollador** y **Depuración USB**.
2) Conecta por USB y acepta el prompt de autorización.
3) Ejecuta:

```bash
flutter run -d <deviceId>
```

### iOS (iPhone / iPad)

1) Conecta el dispositivo por USB.
2) En el iPhone: **Confía** en el equipo y activa **Developer Mode** (iOS 16+).
3) En Xcode configura el firmado:
	 - Abre `ios/Runner.xcworkspace`
	 - Target **Runner** → **Signing & Capabilities**
	 - Selecciona tu **Team** y un **Bundle Identifier** válido
4) Ejecuta:

```bash
flutter run -d <deviceId>
```

### Ejecutar en modo release

```bash
flutter run --release -d <deviceId>
```

## Troubleshooting rápido

```bash
flutter clean
flutter pub get
```

Si hay problemas con código generado:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Si iOS falla por pods:

```bash
cd ios
pod install
cd ..
```

## Preparar para subir a Git

```bash
git status
```

Si aún no existe repo:

```bash
git init
git add .
git commit -m "Initial commit"
```