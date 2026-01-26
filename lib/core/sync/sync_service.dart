import 'package:dio/dio.dart';
import 'package:drift/drift.dart';

import '../database/app_database.dart';

class SyncService {
  final AppDatabase db;
  final Dio dio;

  SyncService({required this.db, required this.dio});

  Future<Response<dynamic>> _postWithOptionalApiFallback(
    String endpoint, {
    required dynamic data,
  }) async {
    try {
      return await dio.post(endpoint, data: data);
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final baseUrl = dio.options.baseUrl;
      final canTryWithoutApi =
          status == 404 && baseUrl.endsWith('/api') && endpoint.startsWith('/');
      if (!canTryWithoutApi) rethrow;

      final baseWithoutApi = baseUrl.substring(0, baseUrl.length - 4);
      final uri = Uri.parse('$baseWithoutApi$endpoint');
      return await dio.postUri(uri, data: data);
    }
  }

  Future<Response<dynamic>> _patchWithOptionalApiFallback(
    String endpoint, {
    required dynamic data,
  }) async {
    try {
      return await dio.patch(endpoint, data: data);
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final baseUrl = dio.options.baseUrl;
      final canTryWithoutApi =
          status == 404 && baseUrl.endsWith('/api') && endpoint.startsWith('/');
      if (!canTryWithoutApi) rethrow;

      final baseWithoutApi = baseUrl.substring(0, baseUrl.length - 4);
      final uri = Uri.parse('$baseWithoutApi$endpoint');
      return await dio.patchUri(uri, data: data);
    }
  }

  /// ASISTENCIA
  Future<void> syncAsistencia(int asistenciaId) async {
    final asistencia = await (db.select(
      db.asistenciaTable,
    )..where((a) => a.id.equals(asistenciaId))).getSingle();

    await dio.post(
      '/asistencia',
      data: {
        'usuarioId': asistencia.usuarioId,
        'fechaHora': asistencia.fechaHora.toIso8601String(),
        'tipo': asistencia.tipo,
        'metodo': asistencia.metodo,
      },
    );

    await (db.update(db.asistenciaTable)
          ..where((a) => a.id.equals(asistenciaId)))
        .write(const AsistenciaTableCompanion(sincronizado: Value(true)));
  }

  /// GLPI
  Future<void> syncGlpiTicket(Map<String, dynamic> payload) async {
    await dio.post('/glpi/tickets', data: payload);
  }

  /// REPORTE
  Future<void> syncReporte(Map<String, dynamic> payload) async {
    final creadorId =
        (payload['creadorId'] ?? payload['creadoPor'] ?? payload['usuarioId'])
            as String?;
    final usuarioId =
        (payload['usuarioId'] ?? payload['creadorId'] ?? payload['creadoPor'])
            as String?;

    final data = <String, dynamic>{
      'id': payload['id'],
      'titulo': payload['titulo'],
      'descripcion': payload['descripcion'],
      'area': payload['area'],
      'estado': payload['estado'],
      'creadorId': creadorId,
      'usuarioId': usuarioId,
    }..removeWhere((_, v) => v == null);

    await dio.post('/reportes', data: data);
  }

  /// COMENTARIO DE REPORTE
  Future<void> syncReporteComentario(Map<String, dynamic> payload) async {
    final data = <String, dynamic>{
      'id': payload['id'],
      'reporteId': payload['reporteId'],
      'usuarioId': payload['usuarioId'] ?? payload['autorId'],
      'mensaje': payload['mensaje'],
    }..removeWhere((_, v) => v == null);

    await dio.post('/reportes/comentarios', data: data);
  }

  /// COMENTARIO DE TAREA
  Future<void> syncTareaComentario(Map<String, dynamic> payload) async {
    final data = <String, dynamic>{
      'id': payload['id'],
      'tareaId': payload['tareaId'],
      'usuarioId': payload['usuarioId'] ?? payload['autorId'],
      'mensaje': payload['mensaje'],
    }..removeWhere((_, v) => v == null);

    await _postWithOptionalApiFallback('/tareas/comentarios', data: data);
  }

  /// ADJUNTO DE TAREA
  Future<void> syncTareaAdjunto(Map<String, dynamic> payload) async {
    final filePath = payload['localPath'] as String;

    final formData = FormData.fromMap({
      'id': payload['id'],
      'tareaId': payload['tareaId'],
      'tipo': payload['tipo'],
      'nombre': payload['nombre'],
      'file': await MultipartFile.fromFile(filePath),
    });

    final resp = await _postWithOptionalApiFallback(
      '/tareas/adjuntos',
      data: formData,
    );

    final data = resp.data;
    if (data is Map) {
      final url = (data['url'] ?? data['remoteUrl'])?.toString();
      if (url != null && url.isNotEmpty) {
        await (db.update(db.tareaAdjuntosTable)
              ..where((a) => a.id.equals(payload['id'] as String)))
            .write(TareaAdjuntosTableCompanion(remoteUrl: Value(url)));
      }
    }
  }

  /// CAMBIO DE ESTADO DE TAREA
  Future<void> syncTareaEstado(Map<String, dynamic> payload) async {
    final id = payload['id']?.toString();
    final estado = payload['estado']?.toString();
    if (id == null || id.isEmpty || estado == null || estado.isEmpty) {
      throw StateError('Payload de estado incompleto: $payload');
    }

    // Intento 1: PATCH /tareas/:id (backend moderno)
    try {
      await _patchWithOptionalApiFallback(
        '/tareas/$id',
        data: {'estado': estado},
      );
      return;
    } on DioException {
      // Intento 2: POST /tareas/estado (si existe)
      await _postWithOptionalApiFallback(
        '/tareas/estado',
        data: {'id': id, 'estado': estado},
      );
    }
  }

  /// EVIDENCIA (UPLOAD DE ARCHIVO)
  Future<void> syncReporteEvidencia(Map<String, dynamic> payload) async {
    final filePath = payload['localPath'] as String;

    final formData = FormData.fromMap({
      'id': payload['id'],
      'reporteId': payload['reporteId'],
      'tipo': payload['tipo'],
      'nombre': payload['nombre'],
      'file': await MultipartFile.fromFile(filePath),
    });

    await dio.post('/reportes/evidencias', data: formData);
  }

  /// TAREA
  Future<Map<String, dynamic>?> syncTarea(Map<String, dynamic> payload) async {
    bool isConflictOk(int? code) => code == 409;

    Future<Response<dynamic>> postWithOptionalApiFallback(
      String endpoint, {
      required Map<String, dynamic> data,
    }) async {
      return _postWithOptionalApiFallback(endpoint, data: data);
    }

    String normalizeEstado(String raw) {
      // Compat entre app (enProceso) y backends (en_proceso/en_progreso).
      return switch (raw) {
        'enProceso' => 'en_proceso',
        'en_progreso' => 'en_progreso',
        _ => raw,
      };
    }

    final titulo = payload['titulo'] as String?;
    final estadoRaw = payload['estado'] as String?;
    final creadorId = (payload['creadorId'] ?? payload['creadoPor']) as String?;
    final descripcionRaw = (payload['descripcion'] as String?) ?? '';
    final asignadoA = payload['asignadoA'] as String?;

    if (titulo == null || estadoRaw == null || creadorId == null) {
      throw StateError('Payload de tarea incompleto: $payload');
    }

    final estado = normalizeEstado(estadoRaw);
    final descripcion = (descripcionRaw.trim().isEmpty)
        ? titulo
        : descripcionRaw.trim();

    // Backend LEGACY (public.tareas) NO acepta: id/estado/creadorId/asignaciones.
    // Espera: titulo, descripcion?, estatus, usuario_asignado, asignado_por, fecha_limite?
    final usuarioAsignado =
        (payload['usuario_asignado'] ?? asignadoA) as String?;
    if (usuarioAsignado == null || usuarioAsignado.isEmpty) {
      throw StateError(
        'Payload de tarea incompleto (usuario_asignado): $payload',
      );
    }

    final legacyData = <String, dynamic>{
      'titulo': titulo,
      'descripcion': descripcion,
      'estatus': estado,
      'usuario_asignado': usuarioAsignado,
      // opcional
      if (payload['fecha_limite'] != null)
        'fecha_limite': payload['fecha_limite'],
    }..removeWhere((_, v) => v == null);

    final legacyEndpoints = <String>['/tareas'];

    DioException? last;
    for (final ep in legacyEndpoints) {
      try {
        // ignore: avoid_print
        print('[SYNC] POST $ep (legacy tarea) data=$legacyData');
        final response = await postWithOptionalApiFallback(
          ep,
          data: legacyData,
        );
        // ignore: avoid_print
        print('[SYNC] POST $ep (legacy tarea) -> OK');
        final data = response.data;
        return (data is Map<String, dynamic>) ? data : null;
      } on DioException catch (e) {
        // ignore: avoid_print
        print(
          '[SYNC] POST $ep (legacy tarea) -> ${e.response?.statusCode} ${e.message} body=${e.response?.data}',
        );
        if (isConflictOk(e.response?.statusCode)) return null;
        last = e;
      }
    }
    if (last != null) throw last;
    return null;
  }
}
