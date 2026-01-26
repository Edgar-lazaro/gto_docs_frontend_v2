import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_ref.dart';

class UsersRepository {
  static const _cacheKey = 'users_cache_v1';

  final Dio dio;
  final SharedPreferences prefs;

  UsersRepository({required this.dio, required this.prefs});

  List<UserRef>? getCached() {
    final raw = prefs.getString(_cacheKey);
    if (raw == null || raw.trim().isEmpty) return null;

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return null;

      final users = <UserRef>[];
      for (final item in decoded) {
        if (item is! Map) continue;
        final map = item.cast<String, dynamic>();
        final id = (map['id'] ?? map['userId'] ?? map['uuid'] ?? '').toString();
        final name = (map['name'] ?? map['nombre'] ?? map['username'] ?? '')
            .toString();
        if (id.trim().isEmpty || name.trim().isEmpty) continue;
        users.add(UserRef(id: id, name: name));
      }
      users.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
      return users;
    } catch (_) {
      return null;
    }
  }

  Future<List<UserRef>> fetchAndCache({int? gerenciaId}) async {
    final candidates = <_UsersCandidate>[
      // Preferimos endpoints genéricos, para evitar routers que tratan subrutas como /tareas/:id (ej. "Invalid id").
      _UsersCandidate('/users', _qpGerencia(gerenciaId)),
      _UsersCandidate('/usuarios', _qpGerencia(gerenciaId)),

      // Endpoints legacy/alternativos (si existen)
      _UsersCandidate('/tareas/asignables', null),
      _UsersCandidate('/tareas/usuarios', null),
    ];

    Future<Response<dynamic>> getWithOptionalApiFallback(
      _UsersCandidate candidate,
    ) async {
      try {
        return await dio.get(
          candidate.path,
          queryParameters: candidate.queryParameters,
        );
      } on DioException catch (e) {
        final status = e.response?.statusCode;
        final baseUrl = dio.options.baseUrl;
        final canTryWithoutApi =
            status == 404 &&
            baseUrl.endsWith('/api') &&
            candidate.path.startsWith('/');
        if (!canTryWithoutApi) rethrow;

        final baseWithoutApi = baseUrl.substring(0, baseUrl.length - 4);
        final uri = Uri.parse('$baseWithoutApi${candidate.path}').replace(
          queryParameters: candidate.queryParameters?.map(
            (k, v) => MapEntry(k, v?.toString() ?? ''),
          ),
        );
        return await dio.getUri(uri);
      }
    }

    DioException? last;

    for (final c in candidates) {
      try {
        final res = await getWithOptionalApiFallback(c);
        final parsed = _parseUsersPayload(res.data);
        if (parsed.isEmpty) {
          continue;
        }

        await _writeCache(parsed);
        return parsed;
      } on DioException catch (e) {
        final status = e.response?.statusCode;
        if (status == 401 || status == 403) {
          throw StateError('No autorizado: inicia sesión de nuevo');
        }
        if (status == 404) {
          last = e;
          continue;
        }

        // Algunos backends enrutan /tareas/<algo> como /tareas/:id.
        // En ese caso, "asignables"/"usuarios" provoca 400 "Invalid id".
        if (status == 400) {
          final msg = (e.response?.data is Map)
              ? ((e.response?.data as Map)['message'] ?? '').toString()
              : (e.response?.data ?? '').toString();
          if (msg.toLowerCase().contains('invalid id')) {
            last = e;
            continue;
          }
        }
        last = e;
      }
    }

    if (last != null) throw last;
    throw StateError(
      'No se pudo cargar usuarios. El backend no expuso un endpoint de usuarios o requiere un parámetro adicional.',
    );
  }

  Future<List<UserRef>> getUsers({int? gerenciaId}) async {
    try {
      return await fetchAndCache(gerenciaId: gerenciaId);
    } on DioException catch (e) {
      final cached = getCached();
      if (cached != null && cached.isNotEmpty) return cached;

      if (_isConnectivityError(e)) {
        final baseUrl = dio.options.baseUrl;
        throw StateError(
          'Servidor no disponible. Verifica que estés en la LAN/VPN y que el backend esté encendido. ($baseUrl)',
        );
      }

      rethrow;
    } catch (_) {
      final cached = getCached();
      if (cached != null && cached.isNotEmpty) return cached;
      rethrow;
    }
  }

  bool _isConnectivityError(DioException e) {
    return e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout;
  }

  Future<void> _writeCache(List<UserRef> users) async {
    final payload = users
        .map((u) => <String, dynamic>{'id': u.id, 'name': u.name})
        .toList(growable: false);
    await prefs.setString(_cacheKey, jsonEncode(payload));
  }

  List<UserRef> _parseUsersPayload(dynamic data) {
    dynamic listData = data;

    if (data is Map) {
      final map = data.cast<String, dynamic>();
      listData =
          map['data'] ??
          map['items'] ??
          map['usuarios'] ??
          map['users'] ??
          map['asignables'] ??
          map['result'];
    }

    if (listData is! List) return const <UserRef>[];

    final users = <UserRef>[];
    for (final item in listData) {
      if (item is! Map) continue;
      final map = item.cast<String, dynamic>();

      final id =
          (map['id'] ??
                  map['userId'] ??
                  map['usuarioId'] ??
                  map['usuario_id'] ??
                  map['uuid'] ??
                  '')
              .toString();

      final nombre = (map['nombre'] ?? map['name'] ?? map['username'] ?? '')
          .toString();
      final apellido = (map['apellido'] ?? map['lastName'] ?? '').toString();

      final displayName =
          ('${nombre.trim()} ${apellido.trim()}'.trim().isNotEmpty
                  ? '${nombre.trim()} ${apellido.trim()}'.trim()
                  : id)
              .trim();

      if (id.trim().isEmpty || displayName.isEmpty) continue;
      users.add(UserRef(id: id, name: displayName));
    }

    users.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return users;
  }

  Map<String, dynamic>? _qpGerencia(int? gerenciaId) {
    if (gerenciaId == null) return null;
    return {
      'gerenciaId': gerenciaId,
    };
  }
}

class _UsersCandidate {
  final String path;
  final Map<String, dynamic>? queryParameters;

  _UsersCandidate(this.path, this.queryParameters);
}
