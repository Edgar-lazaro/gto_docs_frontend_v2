import 'package:dio/dio.dart';

import '../domain/activo.dart';

class InventarioApiRepository {
  final Dio dio;

  InventarioApiRepository({required this.dio});

  Future<List<Activo>> obtenerInventario({
    int? gerenciaId,
    int? jefaturaId,
  }) async {
    final candidates = <_RequestCandidate>[
      // Endpoint confirmado: /api/inventario-tics
      _RequestCandidate(
        '/inventario-tics',
        _qp(gerenciaId: gerenciaId, jefaturaId: jefaturaId),
      ),
      _RequestCandidate(
        '/inventario_tics',
        _qp(gerenciaId: gerenciaId, jefaturaId: jefaturaId),
      ),
      _RequestCandidate(
        '/inventarios',
        _qp(gerenciaId: gerenciaId, jefaturaId: jefaturaId),
      ),
      _RequestCandidate(
        '/inventario',
        _qp(gerenciaId: gerenciaId, jefaturaId: jefaturaId),
      ),
    ];

    final res = await _getFirstOk(candidates);
    final list = _extractList(res.data);

    return list
        .whereType<Map>()
        .map((m) => Activo.fromJson(m.cast<String, dynamic>()))
        .toList();
  }

  Future<Activo> crearActivo(Activo activo) async {
    final payload = activo.toJson()..remove('id');

    final candidates = <String>[
      '/inventario-tics',
      '/inventarios',
      '/inventario',
    ];
    DioException? last;

    for (final path in candidates) {
      try {
        final res = await _requestWithOptionalApiFallback(
          method: 'POST',
          path: path,
          data: payload,
        );
        final data = res.data;
        if (data is Map) {
          return Activo.fromJson(data.cast<String, dynamic>());
        }
        return activo;
      } on DioException catch (e) {
        last = e;
        if (e.response?.statusCode == 404) continue;
        rethrow;
      }
    }

    if (last != null) throw last;
    throw StateError('Inventario: no se encontró endpoint para crear');
  }

  Future<void> actualizarActivo(Activo activo) async {
    final payload = activo.toJson();
    final id = activo.id;

    final candidates = <String>[
      '/inventario-tics/$id',
      '/inventarios/$id',
      '/inventario/$id',
    ];

    DioException? last;
    for (final path in candidates) {
      try {
        await _requestWithOptionalApiFallback(
          method: 'PUT',
          path: path,
          data: payload,
        );
        return;
      } on DioException catch (e) {
        last = e;
        if (e.response?.statusCode == 404) continue;
        // Algunos backends solo aceptan PATCH
        if (e.response?.statusCode == 405) {
          try {
            await _requestWithOptionalApiFallback(
              method: 'PATCH',
              path: path,
              data: payload,
            );
            return;
          } on DioException {
            rethrow;
          }
        }
        rethrow;
      }
    }

    if (last != null) throw last;
    throw StateError('Inventario: no se encontró endpoint para actualizar');
  }

  Future<void> eliminarActivo(String id) async {
    final candidates = <String>[
      '/inventario-tics/$id',
      '/inventarios/$id',
      '/inventario/$id',
    ];

    DioException? last;
    for (final path in candidates) {
      try {
        await _requestWithOptionalApiFallback(method: 'DELETE', path: path);
        return;
      } on DioException catch (e) {
        last = e;
        if (e.response?.statusCode == 404) continue;
        rethrow;
      }
    }

    if (last != null) throw last;
    throw StateError('Inventario: no se encontró endpoint para eliminar');
  }

  Map<String, dynamic>? _qp({int? gerenciaId, int? jefaturaId}) {
    final qp = <String, dynamic>{};
    if (gerenciaId != null) {
      qp['gerencia'] = gerenciaId;
      qp['gerencia_id'] = gerenciaId;
      qp['gerenciaId'] = gerenciaId;
    }
    if (jefaturaId != null) {
      qp['jefatura'] = jefaturaId;
      qp['jefatura_id'] = jefaturaId;
      qp['jefaturaId'] = jefaturaId;
    }
    return qp.isEmpty ? null : qp;
  }

  Future<Response<dynamic>> _getFirstOk(
    List<_RequestCandidate> candidates,
  ) async {
    DioException? lastDioError;

    for (final c in candidates) {
      try {
        return await _requestWithOptionalApiFallback(
          method: 'GET',
          path: c.path,
          queryParameters: c.queryParameters,
        );
      } on DioException catch (e) {
        lastDioError = e;
        final status = e.response?.statusCode;

        // Si el endpoint no existe, probamos el siguiente candidato.
        if (status == 404) continue;

        rethrow;
      }
    }

    if (lastDioError != null) throw lastDioError;
    throw StateError('Inventario: no se encontró un endpoint disponible');
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

  Future<Response<dynamic>> _requestWithOptionalApiFallback({
    required String method,
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    try {
      return await dio.request(
        path,
        options: Options(method: method),
        queryParameters: queryParameters,
        data: data,
      );
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final baseUrl = dio.options.baseUrl;
      final is404 = status == 404;

      if (!is404 || !path.startsWith('/')) rethrow;

      // Si baseUrl NO termina con /api pero el backend real vive bajo /api,
      // probamos agregando /api al path.
      if (!baseUrl.endsWith('/api') && !path.startsWith('/api/')) {
        return await dio.request(
          '/api$path',
          options: Options(method: method),
          queryParameters: queryParameters,
          data: data,
        );
      }

      // Si baseUrl termina con /api pero el endpoint real NO lleva /api,
      // probamos sin /api.
      if (baseUrl.endsWith('/api')) {
        final baseWithoutApi = baseUrl.substring(0, baseUrl.length - 4);
        final uri = Uri.parse('$baseWithoutApi$path').replace(
          queryParameters: queryParameters?.map(
            (k, v) => MapEntry(k, v?.toString() ?? ''),
          ),
        );
        return await dio.requestUri(
          uri,
          options: Options(method: method),
          data: data,
        );
      }

      rethrow;
    }
  }
}

class _RequestCandidate {
  final String path;
  final Map<String, dynamic>? queryParameters;

  _RequestCandidate(this.path, this.queryParameters);
}
