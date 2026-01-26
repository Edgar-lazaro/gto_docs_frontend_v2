import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/security/app_disable_guard.dart';
import 'core/security/kill_switch/kill_switch_service.dart';
import 'core/pdfs/generated_pdf_providers.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  
  final app = await AppDisableGuard.guard(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const App(),
    ),
    killSwitch: const KillSwitchService(),
    hasLan: true,
  );

  runApp(app);
}
