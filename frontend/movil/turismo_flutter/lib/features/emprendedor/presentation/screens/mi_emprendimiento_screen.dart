import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';
import 'package:turismo_flutter/core/utils/auth_utils.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/emprendimiento_emprendedor_dto.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/emprendimiento/emprendimiento_emprendedor_bloc.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/emprendimiento/emprendimiento_emprendedor_event.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/emprendimiento/emprendimiento_emprendedor_state.dart';
import 'package:turismo_flutter/features/general/presentation/widgets/foto_rectangulo_widget.dart';

class MiEmprendimientoScreen extends StatefulWidget {

  const MiEmprendimientoScreen({super.key});

  @override
  State<MiEmprendimientoScreen> createState() => _MiEmprendimientoScreenState();
}

class _MiEmprendimientoScreenState extends State<MiEmprendimientoScreen> {
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _latitudController = TextEditingController();
  final _longitudController = TextEditingController();
  int? _idFamiliaCategoria;
  File? _selectedImage;
  int? _idEmprendimiento;

  @override
  void initState() {
    super.initState();
    _cargarEmprendimiento();
  }

  Future<void> _cargarEmprendimiento() async {
    final tokenService = TokenStorageService();
    final token = await tokenService.getToken();

    if (token != null) {
      final int? idUsuario = getIdUsuarioFromToken(token);
      if (idUsuario != null) {
        context.read<EmprendimientoEmprendedorBloc>().add(
          GetEmprendimientoByIdUsuarioEmprendedorEvent(idUsuario),
        );
      } else {
        print("ID de usuario no válido");
      }
    } else {
      print("Token no encontrado");
    }
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
    }
  }

  void _updateEmprendimiento() {
    if (_idEmprendimiento == null || _idFamiliaCategoria == null) return;

    final dto = EmprendimientoEmprendedorDto(
      nombre: _nombreController.text,
      descripcion: _descripcionController.text,
      latitud: _latitudController.text,
      longitud: _longitudController.text,
      idFamiliaCategoria: _idFamiliaCategoria!,
    );

    context.read<EmprendimientoEmprendedorBloc>().add(
      UpdateEmprendimientoEmprendedorEvent(
        _idEmprendimiento!,
        dto,
        _selectedImage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<EmprendimientoEmprendedorBloc, EmprendimientoEmprendedorState>(
        listener: (context, state) {
          if (state is EmprendimientoEmprendedorUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('¡Emprendimiento actualizado con éxito!')),
            );
          } else if (state is EmprendimientoEmprendedorError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is EmprendimientoEmprendedorLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EmprendimientoEmprendedorLoaded) {
            final emprendimiento = state.response;
            _nombreController.text = emprendimiento.nombre;
            _descripcionController.text = emprendimiento.descripcion;
            _latitudController.text = emprendimiento.latitud;
            _longitudController.text = emprendimiento.longitud;
            _idFamiliaCategoria = 1; // ← reemplaza esto según tu lógica
            _idEmprendimiento = emprendimiento.idEmprendimiento;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _selectedImage != null
                      ? Image.file(_selectedImage!, height: 200)
                      : FotoRectanguloWidget(fileName: emprendimiento.imagenUrl),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image),
                    label: const Text('Cambiar imagen'),
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
                    controller: _latitudController,
                    decoration: const InputDecoration(labelText: 'Latitud'),
                  ),
                  TextField(
                    controller: _longitudController,
                    decoration: const InputDecoration(labelText: 'Longitud'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _updateEmprendimiento,
                    icon: const Icon(Icons.save),
                    label: const Text('Actualizar'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  ),
                ],
              ),
            );
          } else if (state is EmprendimientoEmprendedorError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("No hay datos disponibles"));
          }
        },
      ),
    );
  }
}