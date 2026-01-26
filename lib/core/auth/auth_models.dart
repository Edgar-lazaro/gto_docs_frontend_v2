/// Usuario autenticado en la app
class AuthUser {
  /// Identificador único del usuario
  final String id;

  final String nombre;
  final String area;
  /// Gerencia a la que pertenece el usuario
  final String gerencia;
  final List<String> roles;

  const AuthUser({
    required this.id,
    required this.nombre,
    required this.area,
    this.gerencia = '',
    required this.roles,
  });
}

/// Estados posibles de autenticación
enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
  blocked,
}

class AuthState {
  final AuthStatus status;
  final AuthUser? user;

  const AuthState({
    required this.status,
    this.user,
  });

  factory AuthState.unknown() =>
      const AuthState(status: AuthStatus.unknown);

  factory AuthState.authenticated(AuthUser user) =>
      AuthState(status: AuthStatus.authenticated, user: user);

  factory AuthState.unauthenticated() =>
      const AuthState(status: AuthStatus.unauthenticated);

  factory AuthState.blocked() =>
      const AuthState(status: AuthStatus.blocked);
}