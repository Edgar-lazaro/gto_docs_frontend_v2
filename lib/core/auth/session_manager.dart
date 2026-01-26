import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'auth_models.dart';

class SessionManager {
  static const _storage = FlutterSecureStorage();

  static const _tokenKey = 'auth_token';
  static const _userKey = 'auth_user';

  /// Guarda sesión completa (token + usuario)
  Future<void> save(SessionData session) async {
    await _storage.write(
      key: _tokenKey,
      value: session.token,
    );

    await _storage.write(
      key: _userKey,
      value: jsonEncode(_userToJson(session.user)),
    );
  }

  /// Obtiene usuario actual (si existe)
  Future<AuthUser?> getUser() async {
    final json = await _storage.read(key: _userKey);
    if (json == null) return null;

    final map = jsonDecode(json) as Map<String, dynamic>;
    return _userFromJson(map);
  }

  /// Obtiene token JWT
  Future<String?> getToken() async {
    return _storage.read(key: _tokenKey);
  }

  /// Elimina sesión (logout / bloqueo)
  Future<void> clear() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userKey);
  }

  Map<String, dynamic> _userToJson(AuthUser user) {
    return {
      'id': user.id,
      'nombre': user.nombre,
      'area': user.area,
      'gerencia': user.gerencia,
      'roles': user.roles,
    };
  }

  AuthUser _userFromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      area: json['area'] as String,
      gerencia: (json['gerencia'] ?? '').toString(),
      roles: List<String>.from(json['roles']),
    );
  }
}

/// Estructura interna de sesión
class SessionData {
  final String token;
  final AuthUser user;

  SessionData({
    required this.token,
    required this.user,
  });
}