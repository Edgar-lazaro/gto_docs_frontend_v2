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
flutter run
```


### Ejecutar en modo release

```bash
flutter run --release
```



- Limpieza general:

```bash
flutter clean
flutter pub get
```