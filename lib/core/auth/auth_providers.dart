import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/providers.dart';
import 'api_auth_repository.dart';
import 'auth_controller.dart';
import 'auth_repository.dart';
import 'auth_service.dart';
import 'session_manager.dart';
import 'auth_models.dart';

/// Session manager 
final sessionManagerProvider = Provider<SessionManager>((ref) {
  return SessionManager();
});

/// Auth repository 
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return ApiAuthRepository(
    dio: ref.read(dioProvider),
  );
});

/// Auth service 
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(
    ref.read(authRepositoryProvider),
  );
});

/// Auth controller 
final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(
    repo: ref.read(authRepositoryProvider),
    session: ref.read(sessionManagerProvider),
    ref: ref,
  );
});