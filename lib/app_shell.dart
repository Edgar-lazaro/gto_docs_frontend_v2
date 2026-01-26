import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/auth/auth_models.dart';
import 'core/auth/auth_providers.dart';
import 'core/auth/presentation/login_page.dart';
import 'core/sync/sync_providers.dart';
import 'shared/ui/unified_home_screen.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  @override
  Widget build(BuildContext context) {
    // Activa el listener global de sincronización (LAN → SyncWorker).
    ref.watch(syncListenerProvider);

    final auth = ref.watch(authControllerProvider);

    if (auth.status == AuthStatus.unknown) {
      return const Center(child: CircularProgressIndicator());
    }

    if (auth.status == AuthStatus.blocked) {
      return const Center(child: Text('Aplicación deshabilitada'));
    }

    if (auth.status != AuthStatus.authenticated || auth.user == null) {
      return const LoginPage();
    }

    return UnifiedHomeScreen(user: auth.user!);
  }
}