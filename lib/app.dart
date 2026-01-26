import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'shared/ui/lan_status_banner.dart';
import 'shared/ui/theme/app_theme.dart';
import 'app_shell.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: Stack(
          children: const [
            AppShell(),
            Positioned(left: 0, right: 0, top: 0, child: LanStatusBanner()),
          ],
        ),
      ),
    );
  }
}
