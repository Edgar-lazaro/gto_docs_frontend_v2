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

## Archivos generados por el usuario (PC como servidor)

Si el requerimiento es que **PDFs e imágenes subidas/generadas por el usuario** se guarden en una carpeta aparte (simulando una PC en la LAN como servidor), la práctica recomendada es:

1) **Carpeta de almacenamiento fuera de `assets/`**
	 - `assets/` es solo para archivos empaquetados con la app Flutter.
	 - Los archivos generados/subidos deben guardarse en la PC servidor (backend) en una carpeta tipo:
		 - `server_storage/` (en este repo, recomendado para LAN)
			 - `server_storage/imagenes/tareas/`
			 - `server_storage/imagenes/reportes/`
			 - `server_storage/imagenes/checklists/`
			 - `server_storage/documentos/tareas/pdfs/`
			 - `server_storage/documentos/tareas/otros/`
			 - `server_storage/documentos/reportes/pdfs/`
			 - `server_storage/documentos/reportes/otros/`
			 - `server_storage/documentos/checklists/pdfs/`
			 - `server_storage/documentos/checklists/otros/`

2) **Backend sirve esos archivos como estáticos**
	 - Configurar el backend para escribir a esa carpeta (ej. `STORAGE_ROOT=/ruta/.../server_storage`).
	 - Configurar un base público para construir URLs estables (LAN):
		 - `PUBLIC_BASE_URL=http://ap_ait:3000`
		 - `UPLOADS_BASE=${PUBLIC_BASE_URL}/uploads` (ej: `http://ap_ait:3000/uploads`)
	 - Exponerlos por HTTP: `GET /uploads/...` apuntando a `STORAGE_ROOT`.
	 - Convención de rutas públicas:
		 - Tareas (imágenes): `/uploads/imagenes/tareas/<archivo>`
		 - Tareas (PDFs): `/uploads/documentos/tareas/pdfs/<archivo>`
		 - Tareas (otros docs): `/uploads/documentos/tareas/otros/<archivo>`
		 - Reportes/Checklists (imágenes): `/uploads/imagenes/reportes/<archivo>` y `/uploads/imagenes/checklists/<archivo>`
		 - Reportes/Checklists (PDFs): `/uploads/documentos/reportes/pdfs/<archivo>` y `/uploads/documentos/checklists/pdfs/<archivo>`
		 - Reportes/Checklists (otros docs): `/uploads/documentos/reportes/otros/<archivo>` y `/uploads/documentos/checklists/otros/<archivo>`

3) **Cliente Flutter apunta a la IP de la PC servidor en la LAN**
	- En configuración (dev/qa/prod) usar `apiBaseUrl` = IP/hostname de la PC servidor y el puerto correspondiente.
	- Offline-first: el cliente guarda local y al recuperar LAN sube el archivo; el servidor responde con la URL final.

Notas:
- `server_storage/` está ignorado por git (solo se conserva la estructura con `.gitkeep`).
- En Windows/macOS/Linux, asegurar permisos de escritura para el proceso del backend sobre `server_storage/`.
```