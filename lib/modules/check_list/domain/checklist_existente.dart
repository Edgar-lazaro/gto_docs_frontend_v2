class ChecklistExistente {
  final int id;
  final String nombre;
  final int gerenciaId;
  final int jefaturaId;
  final String funcionForm;

  const ChecklistExistente({
    required this.id,
    required this.nombre,
    required this.gerenciaId,
    required this.jefaturaId,
    required this.funcionForm,
  });

  factory ChecklistExistente.fromJson(Map<String, dynamic> json) {
    final id = json['id'] ?? json['id_cl'] ?? json['checklist_id'];

    return ChecklistExistente(
      id: int.tryParse(id?.toString() ?? '') ?? 0,
      nombre: (json['nombre_cl'] ?? json['nombre'] ?? '').toString(),
      gerenciaId:
          int.tryParse(
            (json['gerencia_cl'] ??
                    json['gerencia_id'] ??
                    json['gerenciaId'] ??
                    '')
                .toString(),
          ) ??
          0,
      jefaturaId:
          int.tryParse(
            (json['jefatura'] ??
                    json['jefatura_id'] ??
                    json['jefaturaId'] ??
                    '')
                .toString(),
          ) ??
          0,
      funcionForm: (json['funcion_form'] ?? json['funcionForm'] ?? '')
          .toString(),
    );
  }
}
