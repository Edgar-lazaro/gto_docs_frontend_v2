import 'auth_models.dart';

extension AuthUserRoleX on AuthUser {
  List<String> get rolesLower => roles.map((e) => e.toLowerCase()).toList();

  bool get isAdmin => rolesLower.any((r) => r.contains('admin'));

  bool get isGerente => rolesLower.any((r) => r.contains('gerente'));

  bool get isJefeDepartamento => rolesLower.any((r) => r.contains('jefe'));

  bool get isSupervisor =>
      isAdmin ||
      isGerente ||
      isJefeDepartamento ||
      rolesLower.any((r) => r.contains('supervisor'));

  bool get isAuxiliar => rolesLower.any((r) => r.contains('aux'));

  /// Intenta obtener un ID numérico estable de gerencia.
  /// Nota: `gerencia` viene a veces como nombre (ej. "TICS") y a veces como ID.
  int? get resolvedGerenciaId {
    final raw = gerencia.trim();
    final parsed = int.tryParse(raw);
    if (parsed != null) return parsed;

    final normalized = raw.toUpperCase();
    switch (normalized) {
      case 'TICS':
        return 1;
      case 'MANTENIMIENTO':
        return 3;
      case 'FAUNA':
        return 4;
      case 'OPERACIONES':
        return 2;
    }

    // Último intento: usar la misma normalización del tema.
    // Si el tema reconoce un ID como texto ('1', '3', etc.), úsalo.
    final tId = int.tryParse(raw);
    if (tId != null) return tId;
    // Si no podemos deducirlo, mejor devolver null para no filtrar mal.
    return null;
  }
}
