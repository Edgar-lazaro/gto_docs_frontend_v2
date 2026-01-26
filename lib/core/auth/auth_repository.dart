import 'session_manager.dart';

abstract class AuthRepository {
  /// Login contra API 
  Future<SessionData> login({
    required String username,
    required String password,
  });

  /// Logout lógico
  Future<void> logout();

  /// Obtiene sesión persistida 
  Future<SessionData?> getSession();
}