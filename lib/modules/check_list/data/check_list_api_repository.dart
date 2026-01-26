import 'package:dio/dio.dart';

import '../domain/checklist_existente.dart';
import '../domain/jefatura.dart';

class CheckListApiRepository {
  final Dio dio;

  CheckListApiRepository({required this.dio});

  Future<List<Jefatura>> obtenerJefaturas({int? gerenciaId}) async {
    final candidates = <_RequestCandidate>[
      // Endpoint confirmado: /api/jefaturas
      _RequestCandidate('/jefaturas', _qp(gerenciaId: gerenciaId)),
      _RequestCandidate('/jefaturas/list', _qp(gerenciaId: gerenciaId)),

      _RequestCandidate('/checklist/jefaturas', _qp(gerenciaId: gerenciaId)),
      _RequestCandidate('/checklists/jefaturas', _qp(gerenciaId: gerenciaId)),
      _RequestCandidate(
        '/checklist/jefaturas/list',
        _qp(gerenciaId: gerenciaId),
      ),
    ];

    final res = await _getFirstOk('jefaturas', candidates);
    final list = _extractList(res.data);

    return list
        .whereType<Map>()
        .map((m) => Jefatura.fromJson(m.cast<String, dynamic>()))
        .toList();
  }

  Future<List<ChecklistExistente>> obtenerClExistentes({
    required int jefaturaId,
    int? gerenciaId,
  }) async {
    final candidates = <_RequestCandidate>[
      // Endpoint confirmado: /api/cl-existentes?jefatura=<ID>
      // Nota: _getWithOptionalApiFallback intentará agregar/quitar /api si hace falta.
      _RequestCandidate('/cl-existentes', {
        ...?_qp(gerenciaId: gerenciaId),
        'jefatura': jefaturaId,
      }),

      // Variantes legacy/compat (algunos backends usan snake_case o nombre distinto)
      _RequestCandidate('/cl-existentes', {
        ...?_qp(gerenciaId: gerenciaId),
        'jefatura_id': jefaturaId,
      }),
      _RequestCandidate('/cl-existentes', {
        ...?_qp(gerenciaId: gerenciaId),
        'jefaturaId': jefaturaId,
      }),
      _RequestCandidate('/cl_existentes', {
        ...?_qp(gerenciaId: gerenciaId),
        'jefatura': jefaturaId,
      }),

      // Fallback viejo (tu log mostraba que se estaba intentando esto, pero en tu backend da 404)
      _RequestCandidate('/checklist/cl_existentes', {
        ...?_qp(gerenciaId: gerenciaId),
        'jefatura': jefaturaId,
      }),
    ];

    final res = await _getFirstOk('cl_existentes', candidates);
    final list = _extractList(res.data);

    final parsed = list
        .whereType<Map>()
        .map((m) => ChecklistExistente.fromJson(m.cast<String, dynamic>()))
        .toList();

    return parsed;
  }

  Map<String, dynamic>? _qp({int? gerenciaId}) {
    if (gerenciaId == null) return null;
    return {
      'gerencia': gerenciaId,
      'gerencia_id': gerenciaId,
      'gerenciaId': gerenciaId,
      'gerencia_cl': gerenciaId,
    };
  }

  Future<Response<dynamic>> _getFirstOk(
    String feature,
    List<_RequestCandidate> candidates,
  ) async {
    DioException? lastDioError;
    DioException? lastAuthError;

    for (final c in candidates) {
      try {
        return await _getWithOptionalApiFallback(
          c.path,
          queryParameters: c.queryParameters,
        );
      } on DioException catch (e) {
        final status = e.response?.statusCode;

        // Si un candidato requiere token/permisos pero hay otro endpoint
        // alternativo que sí funciona, no cortamos aquí.
        if (status == 401 || status == 403) {
          lastAuthError = e;
          continue;
        }

        lastDioError = e;

        if (status == 404) continue;

        // Algunos backends enrutan /checklist/<algo> como /checklist/:id.
        // En ese caso, subrutas como "jefaturas" pueden provocar 400 "Invalid id".
        if (status == 400) {
          final msg = (e.response?.data is Map)
              ? ((e.response?.data as Map)['message'] ?? '').toString()
              : (e.response?.data ?? '').toString();
          if (msg.toLowerCase().contains('invalid id')) {
            continue;
          }
        }

        if (_isConnectivityError(e)) {
          final baseUrl = dio.options.baseUrl;
          throw StateError(
            'Servidor no disponible. Verifica LAN/VPN y el backend. ($baseUrl)',
          );
        }

        rethrow;
      }
    }

    if (lastAuthError != null) {
      throw StateError('No autorizado: inicia sesión de nuevo');
    }

    if (lastDioError != null) {
      final baseUrl = dio.options.baseUrl;
      throw StateError(
        'Checklist: no se encontró endpoint para $feature. ($baseUrl)',
      );
    }

    throw StateError('Checklist: no se encontró un endpoint disponible');
  }

  Future<Response<dynamic>> _getWithOptionalApiFallback(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final baseUrl = dio.options.baseUrl;
      final is404 = status == 404;
      if (!is404 || !path.startsWith('/')) rethrow;

      // Caso A: baseUrl termina con /api pero el path real NO lleva /api (ej: '/jefaturas').
      // Probamos sin /api (baseUrl sin /api).
      if (baseUrl.endsWith('/api')) {
        final baseWithoutApi = baseUrl.substring(0, baseUrl.length - 4);
        final uri = Uri.parse('$baseWithoutApi$path').replace(
          queryParameters: queryParameters?.map(
            (k, v) => MapEntry(k, v?.toString() ?? ''),
          ),
        );
        return await dio.getUri(uri);
      }

      // Caso B: baseUrl NO termina con /api pero el backend real vive bajo /api.
      // Probamos agregando /api al path (sin duplicar).
      if (!path.startsWith('/api/')) {
        return await dio.get('/api$path', queryParameters: queryParameters);
      }

      rethrow;
    }
  }

  bool _isConnectivityError(DioException e) {
    return e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout;
  }

  List<dynamic> _extractList(dynamic data) {
    if (data is List) return data;
    if (data is Map) {
      final map = data.cast<String, dynamic>();
      final v = map['data'] ?? map['items'] ?? map['result'];
      if (v is List) return v;
    }
    return const [];
  }
}

class _RequestCandidate {
  final String path;
  final Map<String, dynamic>? queryParameters;

  _RequestCandidate(this.path, this.queryParameters);
}
