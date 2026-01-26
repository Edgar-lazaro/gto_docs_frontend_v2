import 'auth_repository.dart';
import 'session_manager.dart';

class AuthService {
  final AuthRepository repo;

  AuthService(this.repo);

  Future<SessionData> login({
    required String username,
    required String password,
  }) {
    return repo.login(
      username: username,
      password: password,
    );
  }

  Future<void> logout() async {
    await repo.logout();
  }

  Future<SessionData?> getSession() {
    return repo.getSession();
  }
}