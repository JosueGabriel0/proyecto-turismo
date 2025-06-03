import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/cruds/selector_ubicacion_screen.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/emprendimiento_emprendedor_dto.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/emprendimiento/emprendimiento_emprendedor_bloc.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/emprendimiento/emprendimiento_emprendedor_event.dart';

class EditarEmprendimientoDialog extends StatefulWidget {
  final int idEmprendimiento;
  final String nombre;
  final String descripcion;
  final String latitud;
  final String longitud;
  final int idFamiliaCategoria;

  const EditarEmprendimientoDialog({
    super.key,
    required this.idEmprendimiento,
    required this.nombre,
    required this.descripcion,
    required this.latitud,
    required this.longitud,
    required this.idFamiliaCategoria,
  });

  @override
  State<EditarEmprendimientoDialog> createState() => _EditarEmprendimientoDialogState();
}

class _EditarEmprendimientoDialogState extends State<EditarEmprendimientoDialog> {
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;
  File? _nuevaImagen;

  String? _latitudSeleccionada;
  String? _longitudSeleccionada;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.nombre);
    _descripcionController = TextEditingController(text: widget.descripcion);
    _latitudSeleccionada = widget.latitud;
    _longitudSeleccionada = widget.longitud;
  }

  Future<void> _seleccionarImagen() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _nuevaImagen = File(picked.path));
    }
  }

  void _guardarCambios() {
    final dto = EmprendimientoEmprendedorDto(
      nombre: _nombreController.text,
      descripcion: _descripcionController.text,
      latitud: _latitudSeleccionada ?? widget.latitud,
      longitud: _longitudSeleccionada ?? widget.longitud,
      idFamiliaCategoria: widget.idFamiliaCategoria,
    );

    context.read<EmprendimientoEmprendedorBloc>().add(
      UpdateEmprendimientoEmprendedorEvent(
        widget.idEmprendimiento,
        dto,
        _nuevaImagen,
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Emprendimiento'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            if (_nuevaImagen != null)
              Image.file(_nuevaImagen!, height: 150)
            else
              const Text('No se ha seleccionado imagen'),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _seleccionarImagen,
              icon: const Icon(Icons.image),
              label: const Text('Seleccionar imagen'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: _latitudSeleccionada),
              decoration: const InputDecoration(labelText: 'Latitud'),
            ),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: _longitudSeleccionada),
              decoration: const InputDecoration(labelText: 'Longitud'),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SeleccionUbicacionScreen(
                      latInicial: double.tryParse(widget.latitud),
                      lngInicial: double.tryParse(widget.longitud),
                    ),
                  ),
                );

                if (result != null && result is Map) {
                  setState(() {
                    _latitudSeleccionada = result['lat']?.toString();
                    _longitudSeleccionada = result['lng']?.toString();
                  });
                }
              },
              icon: const Icon(Icons.map),
              label: const Text("Seleccionar ubicación en el mapa"),
            ),
            if (_latitudSeleccionada != null && _longitudSeleccionada != null) ...[
              Builder(
                  builder: (context) {
                    final lat = _latitudSeleccionada!;
                    final lng = _longitudSeleccionada!;

                    final mapUrl =
                        'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/'
                        'pin-s+ff0000($lng,$lat)/'
                        '$lng,$lat,14/300x200?access_token=pk.eyJ1Ijoiam9zdWUyMDAzIiwiYSI6ImNtYWI5eHB4aDFrOXQyam9pY2toMHg1dTEifQ.mioI8UDDcUa9pqKXIsEC6A';

                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.network(
                            mapUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }
              )
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton.icon(
          onPressed: _guardarCambios,
          icon: const Icon(Icons.save),
          label: const Text('Guardar'),
        ),
      ],
    );
  }
}