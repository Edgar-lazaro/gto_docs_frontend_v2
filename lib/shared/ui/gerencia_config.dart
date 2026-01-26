import 'package:flutter/material.dart';

class GerenciaConfig {
  final int id;
  final String nombre;
  final Color colorPrimario;
  final Color colorSecundario;
  final Color colorFondo;
  final IconData iconoPrincipal;

  GerenciaConfig({
    required this.id,
    required this.nombre,
    required this.colorPrimario,
    required this.colorSecundario,
    required this.colorFondo,
    required this.iconoPrincipal,
  });

  // Configuraciones predefinidas por gerencia
  static final Map<int, GerenciaConfig> configs = {
    1: GerenciaConfig(
      id: 1,
      nombre: 'TICS',
      colorPrimario: Color(0xFF1976D2),
      colorSecundario: Color(0xFF42A5F5),
      colorFondo: Color(0xFFE3F2FD),
      iconoPrincipal: Icons.computer,
    ),
    3: GerenciaConfig(
      id: 3,
      nombre: 'Mantenimiento',
      colorPrimario: Color(0xFFFF6F00),
      colorSecundario: Color(0xFFFFB74D),
      colorFondo: Color(0xFFFFF3E0),
      iconoPrincipal: Icons.build,
    ),
    4: GerenciaConfig(
      id: 4,
      nombre: 'Fauna',
      colorPrimario: Color(0xFF388E3C),
      colorSecundario: Color(0xFF66BB6A),
      colorFondo: Color(0xFFE8F5E9),
      iconoPrincipal: Icons.pets,
    ),
  };

  // Obtener configuración por ID con fallback
  static GerenciaConfig getConfig(int? gerenciaId) {
    return configs[gerenciaId] ?? _defaultConfig();
  }

  // Configuración por defecto
  static GerenciaConfig _defaultConfig() {
    return GerenciaConfig(
      id: 0,
      nombre: 'General',
      colorPrimario: Colors.grey[700]!,
      colorSecundario: Colors.grey[500]!,
      colorFondo: Colors.grey[100]!,
      iconoPrincipal: Icons.business,
    );
  }

  // Crear gradiente para headers
  LinearGradient get headerGradient {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [colorPrimario, colorSecundario],
    );
  }
}
