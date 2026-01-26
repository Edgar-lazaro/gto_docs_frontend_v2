import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gto_docs_v2_ad/app.dart';

import 'package:gto_docs_v2_ad/core/auth/auth_providers.dart';
import 'package:gto_docs_v2_ad/core/auth/auth_models.dart';
import 'package:gto_docs_v2_ad/core/auth/session_manager.dart';
import 'package:gto_docs_v2_ad/core/network/lan_status.dart';
import 'package:gto_docs_v2_ad/core/network/lan_status_provider.dart';

class _FakeSessionManager extends SessionManager {
  @override
  Future<void> clear() async {}

  @override
  Future<String?> getToken() async => null;

  @override
  Future<AuthUser?> getUser() async => null;

  @override
  Future<void> save(SessionData session) async {}
}

void main() {
  testWidgets('App shows login when unauthenticated', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          lanStatusProvider.overrideWith((ref) => Stream.value(LanStatus.connected)),
          sessionManagerProvider.overrideWithValue(_FakeSessionManager()),
        ],
        child: const App(),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Iniciar sesión'), findsOneWidget);
  });
}
