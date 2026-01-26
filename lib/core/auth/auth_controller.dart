import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_models.dart';
import 'auth_repository.dart';
import 'session_manager.dart';
import '../network/lan_status.dart';
import '../network/lan_status_provider.dart';
import '../config/config_provider.dart';

class AuthController extends StateNotifier<AuthState> {
  final AuthRepository repo;
  final SessionManager session;
  final Ref ref;

  AuthController({required this.repo, required this.session, required this.ref})
    : super(AuthState.unknown()) {
    _loadSession();
  }

  Future<void> _loadSession() async {
    final user = await session.getUser();
    if (user != null) {
      final config = ref.read(appConfigProvider);
      if (config.useJwt) {
        final token = await session.getToken();
        if (token == null || token.trim().isEmpty) {
          await session.clear();
          state = AuthState.unauthenticated();
          return;
        }
      }

      state = AuthState.authenticated(user);
    } else {
      state = AuthState.unauthenticated();
    }
  }

  Future<void> login(String username, String password) async {
    final lanStatus = ref
        .read(lanStatusProvider)
        .maybeWhen(data: (s) => s, orElse: () => LanStatus.disconnected);

    if (lanStatus != LanStatus.connected) {
      state = AuthState.unauthenticated();
      return;
    }

    try {
      final sessionData = await repo.login(
        username: username,
        password: password,
      );

      await session.save(sessionData);

      state = AuthState.authenticated(sessionData.user);
    } catch (_) {
      state = AuthState.unauthenticated();
    }
  }

  Future<void> logout() async {
    await session.clear();
    state = AuthState.unauthenticated();
  }

 
  void blockApp() {
    state = AuthState.blocked();
  }
}
