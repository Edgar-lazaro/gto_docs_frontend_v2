import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'checklist_models.dart';
import '../../shared/ui/widgets/section_container.dart';

class ChecklistReportForm extends StatefulWidget {
  final ChecklistReportDefinition definition;
  final String initialSite;
  final String initialResponsable;
  final String initialFolio;

  final ValueChanged<ChecklistReportDraft> onSubmit;

  const ChecklistReportForm({
    super.key,
    required this.definition,
    required this.onSubmit,
    this.initialSite = '',
    this.initialResponsable = '',
    this.initialFolio = '',
  });

  @override
  State<ChecklistReportForm> createState() => _ChecklistReportFormState();
}

class _ChecklistReportFormState extends State<ChecklistReportForm> {
  final _picker = ImagePicker();

  late final TextEditingController _site;
  late final TextEditingController _responsable;
  late final TextEditingController _folio;

  late final List<bool> _cumple;
  late final List<bool> _noCumple;
  late final List<bool> _noAplica;
  late final List<TextEditingController> _observaciones;
  late final List<List<XFile>> _images;

  @override
  void initState() {
    super.initState();
    _site = TextEditingController(text: widget.initialSite);
    _responsable = TextEditingController(text: widget.initialResponsable);
    _folio = TextEditingController(text: widget.initialFolio);

    final n = widget.definition.items.length;
    _cumple = List<bool>.filled(n, false);
    _noCumple = List<bool>.filled(n, false);
    _noAplica = List<bool>.filled(n, false);
    _observaciones = List.generate(n, (_) => TextEditingController());
    _images = List.generate(n, (_) => <XFile>[]);
  }

  @override
  void dispose() {
    _site.dispose();
    _responsable.dispose();
    _folio.dispose();
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
          subtitle: 'Captura la información y marca cada punto.',
          icon: Icons.description_outlined,
          child: Column(
            children: [
              _Field(label: widget.definition.locationLabel, controller: _site),
              const SizedBox(height: 12),
              _Field(label: 'Responsable', controller: _responsable),
              const SizedBox(height: 12),
              _Field(label: 'Folio', controller: _folio),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(widget.definition.items.length, (index) {
          final item = widget.definition.items[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _ItemCard(
              index: index,
              label: item.label,
              cumple: _cumple[index],
              noCumple: _noCumple[index],
              noAplica: _noAplica[index],
              observacionController: _observaciones[index],
              images: _images[index],
              onToggleCumple: (v) {
                setState(() {
                  if (_noAplica[index]) return;
                  _cumple[index] = v;
                  if (v) _noCumple[index] = false;
                });
              },
              onToggleNoCumple: (v) {
                setState(() {
                  if (_noAplica[index]) return;
                  _noCumple[index] = v;
                  if (v) _cumple[index] = false;
                });
              },
              onToggleNoAplica: (v) {
                setState(() {
                  _noAplica[index] = v;
                  if (v) {
                    _cumple[index] = false;
                    _noCumple[index] = false;
                    _observaciones[index].text = 'N/A';
                    _observaciones[index]
                        .selection = TextSelection.fromPosition(
                      TextPosition(offset: _observaciones[index].text.length),
                    );
                  } else {
                    if (_observaciones[index].text.trim() == 'N/A') {
                      _observaciones[index].clear();
                    }
                  }
                });
              },
              onAddImage: () => _addImage(index),
              onRemoveImage: (imgIndex) {
                setState(() => _images[index].removeAt(imgIndex));
              },
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

  Future<void> _addImage(int index) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Cámara'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galería'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );

    if (source == null) return;

    if (source == ImageSource.gallery) {
      final picked = await _picker.pickMultiImage(imageQuality: 70);
      if (picked.isEmpty) return;
      setState(() => _images[index].addAll(picked));
      return;
    }

    final picked = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );
    if (picked == null) return;
    setState(() => _images[index].add(picked));
  }

  void _submit() {
    final answers = <ChecklistItemAnswer>[];
    for (var i = 0; i < widget.definition.items.length; i++) {
      final def = widget.definition.items[i];
      final obs = _observaciones[i].text.trim();
      answers.add(
        ChecklistItemAnswer(
          itemId: def.id,
          label: def.label,
          cumple: _cumple[i],
          noCumple: _noCumple[i],
          observacion: _noAplica[i] && obs.isEmpty ? 'N/A' : obs,
          imagePaths: _images[i].map((x) => x.path).toList(),
        ),
      );
    }

    widget.onSubmit(
      ChecklistReportDraft(
        reportTypeId: widget.definition.id,
        reportTitle: widget.definition.title,
        site: _site.text.trim(),
        responsable: _responsable.text.trim(),
        folio: _folio.text.trim(),
        createdAt: DateTime.now(),
        items: answers,
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const _Field({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final int index;
  final String label;
  final bool cumple;
  final bool noCumple;
  final bool noAplica;
  final TextEditingController observacionController;
  final List<XFile> images;

  final ValueChanged<bool> onToggleCumple;
  final ValueChanged<bool> onToggleNoCumple;
  final ValueChanged<bool> onToggleNoAplica;
  final VoidCallback onAddImage;
  final ValueChanged<int> onRemoveImage;

  const _ItemCard({
    required this.index,
    required this.label,
    required this.cumple,
    required this.noCumple,
    required this.noAplica,
    required this.observacionController,
    required this.images,
    required this.onToggleCumple,
    required this.onToggleNoCumple,
    required this.onToggleNoAplica,
    required this.onAddImage,
    required this.onRemoveImage,
  });

  bool get _disableCumpleNoCumple => noAplica;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: cs.primary.withAlpha(18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${index + 1}',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: cs.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              value: noAplica,
              onChanged: (v) => onToggleNoAplica(v ?? false),
              title: const Text('No aplica'),
            ),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: cumple,
                    onChanged: _disableCumpleNoCumple
                        ? null
                        : (v) => onToggleCumple(v ?? false),
                    title: const Text('Cumple'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CheckboxListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: noCumple,
                    onChanged: _disableCumpleNoCumple
                        ? null
                        : (v) => onToggleNoCumple(v ?? false),
                    title: const Text('No cumple'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: observacionController,
              readOnly: noAplica,
              minLines: 1,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Observaciones'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Evidencias',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: onAddImage,
                  icon: const Icon(Icons.add_a_photo),
                  label: const Text('Agregar'),
                ),
              ],
            ),
            if (images.isEmpty)
              Text(
                'Sin fotos',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
              )
            else
              SizedBox(
                height: 72,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    final x = images[i];
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(x.path),
                            width: 72,
                            height: 72,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            visualDensity: VisualDensity.compact,
                            iconSize: 18,
                            onPressed: () => onRemoveImage(i),
                            icon: const Icon(Icons.close),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
