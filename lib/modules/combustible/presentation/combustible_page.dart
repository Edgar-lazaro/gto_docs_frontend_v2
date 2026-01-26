import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/ui/theme/gerencia_config.dart';
import '../../../shared/ui/widgets/gerencia_app_bar.dart';

class CombustiblePage extends StatefulWidget {
  final GerenciaTheme theme;

  const CombustiblePage({super.key, required this.theme});

  @override
  State<CombustiblePage> createState() => _CombustiblePageState();
}

class _CombustiblePageState extends State<CombustiblePage> {
  String _selectedMode = 'usar_vehiculo';
  final ImagePicker _picker = ImagePicker();

  // Listas para almacenar fotos
  final List<XFile> _fotosKmAntes = [];
  final List<XFile> _fotosKmDespues = [];
  final List<XFile> _fotosTicket = [];

  // Listas para fotos de usar vehículo
  final List<XFile> _fotosRegistroInicial = [];
  final List<XFile> _fotosRegistroFinal = [];

  // Controllers para Usar Vehículo
  final _nombreController = TextEditingController();
  final _destinoController = TextEditingController();
  final _horaInicioController = TextEditingController();
  final _combustibleInicialController = TextEditingController();
  final _kilometrajeInicialController = TextEditingController();
  final _horaFinalController = TextEditingController();
  final _combustibleFinalController = TextEditingController();
  final _kilometrajeFinalController = TextEditingController();

  // Controllers para Cargar Combustible
  final _fechaCargaController = TextEditingController();
  final _operadorController = TextEditingController();
  final _kmAntesCargaController = TextEditingController();
  final _kmDespuesCargaController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _destinoController.dispose();
    _horaInicioController.dispose();
    _combustibleInicialController.dispose();
    _kilometrajeInicialController.dispose();
    _horaFinalController.dispose();
    _combustibleFinalController.dispose();
    _kilometrajeFinalController.dispose();
    _fechaCargaController.dispose();
    _operadorController.dispose();
    _kmAntesCargaController.dispose();
    _kmDespuesCargaController.dispose();
    super.dispose();
  }

  LinearGradient get _headerGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [widget.theme.colorPrimario, widget.theme.colorSecundario],
  );

  Future<void> _pickImage(String tipo) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.camera_alt,
                  color: widget.theme.colorPrimario,
                ),
                title: const Text('Tomar foto'),
                onTap: () async {
                  Navigator.pop(context);
                  final photo = await _picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (photo == null || !mounted) return;
                  setState(() {
                    if (tipo == 'kmAntes') {
                      _fotosKmAntes.add(photo);
                    } else if (tipo == 'kmDespues') {
                      _fotosKmDespues.add(photo);
                    } else if (tipo == 'ticket') {
                      _fotosTicket.add(photo);
                    } else if (tipo == 'registroInicial') {
                      _fotosRegistroInicial.add(photo);
                    } else if (tipo == 'registroFinal') {
                      _fotosRegistroFinal.add(photo);
                    }
                  });
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: widget.theme.colorPrimario,
                ),
                title: const Text('Seleccionar de galería'),
                onTap: () async {
                  Navigator.pop(context);
                  final photo = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (photo == null || !mounted) return;
                  setState(() {
                    if (tipo == 'kmAntes') {
                      _fotosKmAntes.add(photo);
                    } else if (tipo == 'kmDespues') {
                      _fotosKmDespues.add(photo);
                    } else if (tipo == 'ticket') {
                      _fotosTicket.add(photo);
                    } else if (tipo == 'registroInicial') {
                      _fotosRegistroInicial.add(photo);
                    } else if (tipo == 'registroFinal') {
                      _fotosRegistroFinal.add(photo);
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _removeImage(String tipo, int index) {
    setState(() {
      if (tipo == 'kmAntes') {
        _fotosKmAntes.removeAt(index);
      } else if (tipo == 'kmDespues') {
        _fotosKmDespues.removeAt(index);
      } else if (tipo == 'ticket') {
        _fotosTicket.removeAt(index);
      } else if (tipo == 'registroInicial') {
        _fotosRegistroInicial.removeAt(index);
      } else if (tipo == 'registroFinal') {
        _fotosRegistroFinal.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final width = MediaQuery.of(context).size.width;
    final horizontalPadding = width >= 1200
        ? 120.0
        : width >= 900
        ? 80.0
        : width >= 600
        ? 60.0
        : 24.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GerenciaAppBar(
        theme: widget.theme,
        title: 'Combustible',
        showBack: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: isTablet ? 32 : 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: _headerGradient,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: widget.theme.colorPrimario.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.local_gas_station,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'Control de Combustible',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Opciones de acción
              SizedBox(
                height: 160,
                child: Row(
                  children: [
                    Expanded(
                      child: _OptionCard(
                        theme: widget.theme,
                        icon: Icons.directions_car,
                        title: 'Usar Vehículo',
                        subtitle: 'Registrar uso',
                        isSelected: _selectedMode == 'usar_vehiculo',
                        onTap: () =>
                            setState(() => _selectedMode = 'usar_vehiculo'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _OptionCard(
                        theme: widget.theme,
                        icon: Icons.local_gas_station,
                        title: 'Cargar Combustible',
                        subtitle: 'Registrar carga',
                        isSelected: _selectedMode == 'cargar_combustible',
                        onTap: () => setState(
                          () => _selectedMode = 'cargar_combustible',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Formulario dinámico
              _selectedMode == 'usar_vehiculo'
                  ? KeyedSubtree(
                      key: const ValueKey('usar_vehiculo_form'),
                      child: _buildUsarVehiculoForm(),
                    )
                  : KeyedSubtree(
                      key: const ValueKey('cargar_combustible_form'),
                      child: _buildCargarCombustibleForm(),
                    ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsarVehiculoForm() {
    return Column(
      children: [
        _SectionCard(
          theme: widget.theme,
          title: 'Información del Conductor',
          icon: Icons.person,
          children: [
            _TextField(
              controller: _nombreController,
              label: 'Nombre del conductor',
              hint: 'Ingrese nombre completo',
              icon: Icons.badge,
              theme: widget.theme,
            ),
            const SizedBox(height: 16),
            _TextField(
              controller: _destinoController,
              label: 'Destino',
              hint: 'Ingrese destino',
              icon: Icons.location_on,
              theme: widget.theme,
            ),
          ],
        ),
        const SizedBox(height: 24),
        _SectionCard(
          theme: widget.theme,
          title: 'Registro Inicial',
          icon: Icons.play_circle_outline,
          children: [
            Row(
              children: [
                Expanded(
                  child: _TextField(
                    controller: _horaInicioController,
                    label: 'Hora de inicio',
                    hint: 'Seleccionar',
                    icon: Icons.access_time,
                    readOnly: true,
                    theme: widget.theme,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    gradient: _headerGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null && mounted) {
                        setState(() {
                          _horaInicioController.text = picked.format(context);
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _TextField(
              controller: _combustibleInicialController,
              label: 'Nivel de combustible',
              hint: 'Ej: 3/4, 1/2, Full',
              icon: Icons.local_gas_station,
              theme: widget.theme,
            ),
            const SizedBox(height: 16),
            _TextField(
              controller: _kilometrajeInicialController,
              label: 'Kilometraje',
              hint: 'Ingrese kilometraje',
              icon: Icons.speed,
              keyboardType: TextInputType.number,
              theme: widget.theme,
            ),
            const SizedBox(height: 16),
            _PhotoSection(
              theme: widget.theme,
              title: 'Fotos del registro inicial',
              files: _fotosRegistroInicial,
              onAdd: () => _pickImage('registroInicial'),
              onRemoveAt: (i) => _removeImage('registroInicial', i),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _SectionCard(
          theme: widget.theme,
          title: 'Registro Final',
          icon: Icons.stop_circle_outlined,
          children: [
            Row(
              children: [
                Expanded(
                  child: _TextField(
                    controller: _horaFinalController,
                    label: 'Hora final',
                    hint: 'Seleccionar',
                    icon: Icons.access_time,
                    readOnly: true,
                    theme: widget.theme,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    gradient: _headerGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null && mounted) {
                        setState(() {
                          _horaFinalController.text = picked.format(context);
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _TextField(
              controller: _combustibleFinalController,
              label: 'Nivel de combustible',
              hint: 'Ej: 3/4, 1/2, Full',
              icon: Icons.local_gas_station,
              theme: widget.theme,
            ),
            const SizedBox(height: 16),
            _TextField(
              controller: _kilometrajeFinalController,
              label: 'Kilometraje',
              hint: 'Ingrese kilometraje',
              icon: Icons.speed,
              keyboardType: TextInputType.number,
              theme: widget.theme,
            ),
            const SizedBox(height: 16),
            _PhotoSection(
              theme: widget.theme,
              title: 'Fotos del registro final',
              files: _fotosRegistroFinal,
              onAdd: () => _pickImage('registroFinal'),
              onRemoveAt: (i) => _removeImage('registroFinal', i),
            ),
          ],
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.theme.colorPrimario,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: const [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 12),
                      Text('Registro guardado'),
                    ],
                  ),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.save, size: 20),
            label: const Text(
              'Guardar Registro',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCargarCombustibleForm() {
    return Column(
      children: [
        _SectionCard(
          theme: widget.theme,
          title: 'Información de Carga',
          icon: Icons.local_gas_station,
          children: [
            Row(
              children: [
                Expanded(
                  child: _TextField(
                    controller: _fechaCargaController,
                    label: 'Fecha de carga',
                    hint: 'Seleccionar',
                    icon: Icons.calendar_today,
                    readOnly: true,
                    theme: widget.theme,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    gradient: _headerGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null && mounted) {
                        setState(() {
                          _fechaCargaController.text =
                              '${picked.day}/${picked.month}/${picked.year}';
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _TextField(
              controller: _operadorController,
              label: 'Operador',
              hint: 'Nombre del operador',
              icon: Icons.person,
              theme: widget.theme,
            ),
          ],
        ),
        const SizedBox(height: 24),
        _SectionCard(
          theme: widget.theme,
          title: 'Kilometraje Antes de Cargar',
          icon: Icons.speed,
          children: [
            _TextField(
              controller: _kmAntesCargaController,
              label: 'Kilómetros antes',
              hint: 'Ingrese kilometraje',
              icon: Icons.speed,
              keyboardType: TextInputType.number,
              theme: widget.theme,
            ),
            const SizedBox(height: 16),
            _PhotoSection(
              theme: widget.theme,
              title: 'Foto de kilometraje antes',
              files: _fotosKmAntes,
              onAdd: () => _pickImage('kmAntes'),
              onRemoveAt: (i) => _removeImage('kmAntes', i),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _SectionCard(
          theme: widget.theme,
          title: 'Kilometraje Después de Cargar',
          icon: Icons.speed,
          children: [
            _TextField(
              controller: _kmDespuesCargaController,
              label: 'Kilómetros después',
              hint: 'Ingrese kilometraje',
              icon: Icons.speed,
              keyboardType: TextInputType.number,
              theme: widget.theme,
            ),
            const SizedBox(height: 16),
            _PhotoSection(
              theme: widget.theme,
              title: 'Foto de kilometraje después',
              files: _fotosKmDespues,
              onAdd: () => _pickImage('kmDespues'),
              onRemoveAt: (i) => _removeImage('kmDespues', i),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _SectionCard(
          theme: widget.theme,
          title: 'Ticket de Carga',
          icon: Icons.receipt,
          children: [
            _PhotoSection(
              theme: widget.theme,
              title: 'Foto del ticket',
              files: _fotosTicket,
              onAdd: () => _pickImage('ticket'),
              onRemoveAt: (i) => _removeImage('ticket', i),
            ),
          ],
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.theme.colorPrimario,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: const [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 12),
                      Text('Carga de combustible registrada'),
                    ],
                  ),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.save, size: 20),
            label: const Text('Guardar Carga', style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}

class _OptionCard extends StatelessWidget {
  final GerenciaTheme theme;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionCard({
    required this.theme,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  LinearGradient get _gradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [theme.colorPrimario, theme.colorSecundario],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? theme.colorPrimario : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          if (isSelected)
            BoxShadow(
              color: theme.colorPrimario.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: isSelected ? _gradient : null,
                    color: isSelected ? null : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.white : Colors.grey[600],
                    size: 32,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? theme.colorPrimario : Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final GerenciaTheme theme;
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
    required this.theme,
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [theme.colorPrimario, theme.colorSecundario],
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final GerenciaTheme theme;
  final bool readOnly;
  final TextInputType? keyboardType;

  const _TextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    required this.theme,
    this.readOnly = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return TextField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      maxLines: 1,
      cursorColor: theme.colorPrimario,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(color: cs.onSurfaceVariant),
        floatingLabelStyle: TextStyle(color: cs.primary),
        prefixIcon: Icon(icon, color: cs.primary),
      ),
    );
  }
}

class _PhotoSection extends StatelessWidget {
  final GerenciaTheme theme;
  final String title;
  final List<XFile> files;
  final VoidCallback onAdd;
  final void Function(int index) onRemoveAt;

  const _PhotoSection({
    required this.theme,
    required this.title,
    required this.files,
    required this.onAdd,
    required this.onRemoveAt,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 12),
        if (files.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[50],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.add_photo_alternate,
                  size: 48,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 8),
                Text('Sin fotos', style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (var i = 0; i < files.length; i++)
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(files[i].path),
                        width: isTablet ? 120 : 100,
                        height: isTablet ? 120 : 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () => onRemoveAt(i),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add_a_photo),
            label: const Text('Agregar foto'),
            style: OutlinedButton.styleFrom(
              foregroundColor: theme.colorPrimario,
              side: BorderSide(color: theme.colorPrimario),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
