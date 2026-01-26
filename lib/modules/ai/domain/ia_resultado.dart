class IaResultado {
  final String reporteId;
  final String categoria;
  final String prioridad;
  final List<String> responsables;

  IaResultado({
    required this.reporteId,
    required this.categoria,
    required this.prioridad,
    required this.responsables,
  });
}