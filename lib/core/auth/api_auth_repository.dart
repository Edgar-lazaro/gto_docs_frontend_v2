import 'package:dio/dio.dart';

import 'auth_repository.dart';
import 'auth_models.dart';
import 'session_manager.dart';

class ApiAuthRepository implements AuthRepository {
  final Dio dio;

  ApiAuthRepository({
    required this.dio,
  });

  @override
  Future<SessionData> login({
    required String username,
    required String password,
  }) async {
    final res = await dio.post(
      '/auth/login',
      data: {
        'username': username,
        'password': password,
      },
    );

    final token = _extractToken(res.data);

    // Obtener usuario autenticado desde /auth/me
    final meRes = await dio.get(
      '/auth/me',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final me = (meRes.data as Map).cast<String, dynamic>();

    final userId = (me['id'] ?? me['userId'] ?? me['sub'] ?? '').toString();
    final nombre = (me['nombre'] ?? me['username'] ?? '').toString();
    final area = (me['area'] ?? '').toString();
    final gerencia = (me['gerencia'] ?? me['gerenciaNombre'] ?? me['gerencia_name'] ?? me['gerenciaId'] ?? me['gerencia_id'] ?? '').toString();
    final rolesRaw = me['roles'];

    return SessionData(
      token: token,
      user: AuthUser(
        id: userId,
        nombre: nombre,
        area: area,
        gerencia: gerencia,
        roles: rolesRaw is List ? rolesRaw.map((e) => e.toString()).toList() : const <String>[],
      ),
    );
  }

  String _extractToken(dynamic data) {
    if (data is String) return data;
    if (data is Map) {
      final map = data.cast<String, dynamic>();
      final token = map['access_token'] ?? map['token'] ?? map['jwt'];
      if (token is String && token.isNotEmpty) return token;
    }
    throw StateError('Login: respuesta sin token');
  }

  @override
  Future<SessionData?> getSession() async {
    // La sesión persistida la maneja SessionManager
    return null;
  }

  @override
  Future<void> logout() async {
    // Opcional: notificar backend
  }
}