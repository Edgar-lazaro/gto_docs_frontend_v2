import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/lan_status.dart';
import '../../core/network/lan_status_provider.dart';

class LanStatusBanner extends ConsumerWidget {
  const LanStatusBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lanAsync = ref.watch(lanStatusProvider);

    return lanAsync.when(
      loading: () => _banner(
        context,
        icon: Icons.wifi_find,
        text: 'Verificando red empresarial…',
        tone: _BannerTone.warning,
      ),
      error: (error, stackTrace) => _banner(
        context,
        icon: Icons.wifi_off,
        text: 'Sin conexión a la red empresarial',
        tone: _BannerTone.error,
      ),
      data: (status) {
        switch (status) {
          case LanStatus.connected:
            return const SizedBox.shrink(); // oculto cuando todo está bien
          case LanStatus.serverDown:
            return _banner(
              context,
              icon: Icons.cloud_off,
              text: 'Servidor interno no disponible',
              tone: _BannerTone.warning,
            );
          case LanStatus.disconnected:
          default:
            return _banner(
              context,
              icon: Icons.wifi_off,
              text: 'Fuera de la red empresarial',
              tone: _BannerTone.error,
            );
        }
      },
    );
  }

  Widget _banner(
    BuildContext context, {
    required IconData icon,
    required String text,
    required _BannerTone tone,
  }) {
    final cs = Theme.of(context).colorScheme;

    final (bg, fg, border) = switch (tone) {
      _BannerTone.error => (
        cs.errorContainer,
        cs.onErrorContainer,
        cs.error.withAlpha(120),
      ),
      _BannerTone.warning => (
        cs.tertiaryContainer,
        cs.onTertiaryContainer,
        cs.tertiary.withAlpha(120),
      ),
      _BannerTone.info => (
        cs.primaryContainer,
        cs.onPrimaryContainer,
        cs.primary.withAlpha(120),
      ),
    };

    return Material(
      color: Colors.transparent,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(18),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                children: [
                  Icon(icon, color: fg),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(color: fg, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum _BannerTone { info, warning, error }
