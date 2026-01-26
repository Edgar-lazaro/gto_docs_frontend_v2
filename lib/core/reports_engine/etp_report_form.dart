import 'package:flutter/material.dart';

import 'etp_models.dart';
import '../../shared/ui/widgets/section_container.dart';

class EtpChecklistForm extends StatefulWidget {
  final EtpChecklistDefinition definition;
  final String userName;
  final String checklistName;

  final ValueChanged<EtpChecklistDraft> onSubmit;

  const EtpChecklistForm({
    super.key,
    required this.definition,
    required this.userName,
    required this.checklistName,
    required this.onSubmit,
  });

  @override
  State<EtpChecklistForm> createState() => _EtpChecklistFormState();
}

class _EtpChecklistFormState extends State<EtpChecklistForm> {
  late final List<bool> _cable;
  late final List<bool> _red;
  late final List<bool> _noAplica;
  late final List<TextEditingController> _anomalias;
  late final List<TextEditingController> _observaciones;

  @override
  void initState() {
    super.initState();
    final n = widget.definition.items.length;
    _cable = List<bool>.filled(n, false);
    _red = List<bool>.filled(n, false);
    _noAplica = List<bool>.filled(n, false);
    _anomalias = List.generate(n, (_) => TextEditingController());
    _observaciones = List.generate(n, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (final c in _anomalias) {
      c.dispose();
    }
    for (final c in _observaciones) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionContainer(
          title: widget.definition.title,
          subtitle: 'Checklist ETP',
          icon: Icons.fact_check_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nombre: ${widget.userName}'),
              Text('Área: ${widget.checklistName}'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(widget.definition.items.length, (index) {
          final item = widget.definition.items[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SectionContainer(
              title: 'Punto ${index + 1}',
              subtitle: item.label,
              icon: Icons.checklist_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckboxListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: _noAplica[index],
                    onChanged: (v) {
                      final value = v ?? false;
                      setState(() {
                        _noAplica[index] = value;
                        if (value) {
                          _cable[index] = false;
                          _red[index] = false;
                          _observaciones[index].text = 'N/A';
                          _observaciones[index].selection =
                              TextSelection.fromPosition(
                                TextPosition(
                                  offset: _observaciones[index].text.length,
                                ),
                              );
                        } else {
                          if (_observaciones[index].text.trim() == 'N/A') {
                            _observaciones[index].clear();
                          }
                        }
                      });
                    },
                    title: const Text('No aplica'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          value: _cable[index],
                          onChanged: _noAplica[index]
                              ? null
                              : (v) =>
                                    setState(() => _cable[index] = v ?? false),
                          title: const Text('Cable roto'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CheckboxListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          value: _red[index],
                          onChanged: _noAplica[index]
                              ? null
                              : (v) => setState(() => _red[index] = v ?? false),
                          title: const Text('Falla red'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _anomalias[index],
                    minLines: 1,
                    maxLines: 2,
                    decoration: const InputDecoration(labelText: 'Anomalías'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _observaciones[index],
                    readOnly: _noAplica[index],
                    minLines: 1,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Observaciones',
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 8),
        FilledButton.icon(
          onPressed: _submit,
          icon: const Icon(Icons.picture_as_pdf),
          label: const Text('Generar PDF'),
        ),
      ],
    );
  }

  void _submit() {
    final answers = <EtpChecklistItemAnswer>[];
    for (var i = 0; i < widget.definition.items.length; i++) {
      final def = widget.definition.items[i];
      final obs = _observaciones[i].text.trim();
      answers.add(
        EtpChecklistItemAnswer(
          itemId: def.id,
          label: def.label,
          cableRoto: _cable[i],
          fallaRed: _red[i],
          anomalias: _anomalias[i].text.trim(),
          observaciones: _noAplica[i] && obs.isEmpty ? 'N/A' : obs,
        ),
      );
    }

    widget.onSubmit(
      EtpChecklistDraft(
        reportTypeId: widget.definition.id,
        reportTitle: widget.definition.title,
        userName: widget.userName,
        checklistName: widget.checklistName,
        createdAt: DateTime.now(),
        items: answers,
      ),
    );
  }
}
