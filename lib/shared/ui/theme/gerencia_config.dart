import 'package:flutter/material.dart';

class GerenciaTheme {
  final String nombre;
  final Color colorPrimario;
  final Color colorSecundario;
  final IconData iconoPrincipal;

  const GerenciaTheme({
    required this.nombre,
    required this.colorPrimario,
    required this.colorSecundario,
    required this.iconoPrincipal,
  });
}

class GerenciaConfig {
  static GerenciaTheme getConfig(String gerenciaId) {
    final normalized = gerenciaId.trim().toUpperCase();

    switch (normalized) {
      case '1':
      case 'TICS':
        return const GerenciaTheme(
          nombre: 'Tecnologías de la Información',
          colorPrimario: Color(0xFF4A90E2),
          colorSecundario: Color(0xFF6FB1FC),
          iconoPrincipal: Icons.computer,
        );
      case '3':
      case 'MANTENIMIENTO':
        return const GerenciaTheme(
          nombre: 'Mantenimiento',
          colorPrimario: Color(0xFFFF6F00),
          colorSecundario: Color(0xFFFFB74D),
          iconoPrincipal: Icons.build,
        );
      case '4':
      case 'FAUNA':
        return const GerenciaTheme(
          nombre: 'Fauna',
          colorPrimario: Color(0xFF388E3C),
          colorSecundario: Color(0xFF66BB6A),
          iconoPrincipal: Icons.pets,
        );
      case 'OPERACIONES':
        return const GerenciaTheme(
          nombre: 'Operaciones',
          colorPrimario: Color(0xFF2ECC71),
          colorSecundario: Color(0xFF58D68D),
          iconoPrincipal: Icons.flight_takeoff,
        );
      default:
        return const GerenciaTheme(
          nombre: 'General',
          colorPrimario: Colors.blue,
          colorSecundario: Colors.lightBlue,
          iconoPrincipal: Icons.business,
        );
    }
  }
}