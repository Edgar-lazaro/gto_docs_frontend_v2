import 'package:flutter/material.dart';
import 'lan_status.dart';

class LanStatusBanner extends StatelessWidget {
  final LanStatus status;

  const LanStatusBanner({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    switch (status) {
      case LanStatus.connected:
        return const SizedBox.shrink();
      case LanStatus.checking:
        color = Colors.orange;
        text = 'Verificando red corporativa...';
        break;
      case LanStatus.serverDown:
        color = Colors.red;
        text = 'Servidor interno no disponible';
        break;
      case LanStatus.disconnected:
        color = Colors.red;
        text = 'Sin conexión a red corporativa';
        break;
    }

    return Container(
      width: double.infinity,
      color: color,
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}