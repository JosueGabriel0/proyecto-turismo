import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart' as imagePicker;
import 'package:turismo_flutter/features/admin/data/models/servicio_turistico_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/servicio_turistico_response.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/servicio_turistico/servicio_turistico_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/servicio_turistico/servicio_turistico_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/servicio_turistico/servicio_turistico_state.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/foto_widget.dart';

class ServicioTuristicoScreen extends StatefulWidget {
  const ServicioTuristicoScreen({super.key});

  @override
  State<ServicioTuristicoScreen> createState() => _ServicioTuristicoScreenState();
}

class _ServicioTuristicoScreenState extends State<ServicioTuristicoScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _servicioEditandoId;

  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _precioController = TextEditingController();
  final _tipoServicioController = TextEditingController();
  final _nombreEmprendimientoController = TextEditingController();

  File? _imagenFile;

  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ServicioTuristicoBloc>().add(GetAllServiciosTuristicosEvent());
  }

  Future<void> _pickImage() async {
    final picker = imagePicker.ImagePicker();
    final pickedImage = await picker.pickImage(source: imagePicker.ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imagenFile = File(pickedImage.path);
      });
    }
  }

  Future<bool?> _onDismissed(BuildContext context, ServicioTuristicoResponse servicio) async {
    final confirmacion = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("¿Confirmar eliminación?"),
        content: Text("¿Está seguro de eliminar el servicio ${servicio.nombre}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancelar")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Eliminar")),
        ],
      ),
    );

    if (confirmacion == true) {
      context.read<ServicioTuristicoBloc>().add(DeleteServicioTuristicoEvent(servicio.idServicio));
    }
    return confirmacion;
  }

  void _cargarParaEditar(ServicioTuristicoResponse servicio) {
    setState(() {
      _servicioEditandoId = servicio.idServicio;
      _nombreController.text = servicio.nombre;
      _descripcionController.text = servicio.descripcion;
      _precioController.text = servicio.precioUnitario.toString();
      _tipoServicioController.text = servicio.tipoServicio;
      _imagenFile = null; // Imagen a cargar puede manejarse si tienes URL, aquí no
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final dto = ServicioTuristicoDto(
        idServicio: _servicioEditandoId ?? 0,
        nombre: _nombreController.text,
        descripcion: _descripcionController.text,
        precioUnitario: double.parse(_precioController.text),
        tipoServicio: _tipoServicioController.text,
        nombreEmprendimiento: _nombreEmprendimientoController.text,
      );

      if (_servicioEditandoId != null) {
        context.read<ServicioTuristicoBloc>().add(PutServicioTuristicoEvent(_servicioEditandoId!, dto, _imagenFile));
      } else {
        context.read<ServicioTuristicoBloc>().add(PostServicioTuristicoEvent(dto, _imagenFile));
      }

      _resetForm();
      Navigator.of(context).pop();
    }
  }

  void _resetForm() {
    _servicioEditandoId = null;
    _nombreController.clear();
    _descripcionController.clear();
    _precioController.clear();
    _tipoServicioController.clear();
    _nombreEmprendimientoController.clear();
    _imagenFile = null;
  }

  void _mostrarFormulario(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: "Nombre"),
                  validator: (v) => v!.isEmpty ? "Campo requerido" : null,
                ),
                TextFormField(
                  controller: _descripcionController,
                  decoration: const InputDecoration(labelText: "Descripción"),
                  validator: (v) => v!.isEmpty ? "Campo requerido" : null,
                ),
                TextFormField(
                  controller: _precioController,
                  decoration: const InputDecoration(labelText: "Precio Unitario"),
                  keyboardType: TextInputType.number,
                  validator: (v) => v!.isEmpty ? "Campo requerido" : null,
                ),
                TextFormField(
                  controller: _tipoServicioController,
                  decoration: const InputDecoration(labelText: "Tipo de Servicio"),
                  validator: (v) => v!.isEmpty ? "Campo requerido" : null,
                ),
                TextFormField(
                  controller: _nombreEmprendimientoController,
                  decoration: const InputDecoration(labelText: "Nombre Emprendimiento"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text("Seleccionar Imagen"),
                ),
                if (_imagenFile != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text("Imagen seleccionada"),
                  ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(_servicioEditandoId == null ? "Crear" : "Actualizar"),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        _resetForm();
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancelar"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocListener<ServicioTuristicoBloc, ServicioTuristicoState>(
          listener: (context, state) {
            if (state is ServicioTuristicoSuccess) {
              context.read<ServicioTuristicoBloc>().add(GetAllServiciosTuristicosEvent());
            }
          },
          child: BlocBuilder<ServicioTuristicoBloc, ServicioTuristicoState>(
            builder: (context, state) {
              if (state is ServicioTuristicoLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ServicioTuristicoListLoaded) {
                return Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: 'Buscar servicio...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        context.read<ServicioTuristicoBloc>().add(BuscarServiciosTuristicosPorNombreEvent(value));
                      },
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.serviciosTuristicos.length,
                        itemBuilder: (context, index) {
                          final servicio = state.serviciosTuristicos[index];
                          return Dismissible(
                            key: Key(servicio.idServicio.toString()),
                            confirmDismiss: (_) => _onDismissed(context, servicio),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            child: ListTile(
                              leading: servicio.imagenUrl != null
                                  ? FotoWidget(fileName: servicio.imagenUrl)
                                  : const Icon(Icons.image_not_supported),
                              title: Text(servicio.nombre),
                              subtitle: Text(servicio.descripcion),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.info),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: Text("Información del servicio"),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                if (servicio.imagenUrl != null)
                                                  Center(
                                                    child: Image.network(servicio.imagenUrl, width: 80, height: 80),
                                                  ),
                                                const SizedBox(height: 16),
                                                Text("ID: ${servicio.idServicio}"),
                                                Text("Nombre: ${servicio.nombre}"),
                                                Text("Descripción: ${servicio.descripcion}"),
                                                Text("Precio Unitario: ${servicio.precioUnitario}"),
                                                Text("Tipo Servicio: ${servicio.tipoServicio}"),
                                                Text("Fecha creación: ${servicio.fechaCreacion}"),
                                                Text("Fecha modificación: ${servicio.fechaModificacion ?? '-'}"),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.of(context).pop(),
                                              child: const Text("Cerrar"),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      _cargarParaEditar(servicio);
                                      _mostrarFormulario(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (state is ServicioTuristicoError) {
                return Center(
                  child: Text(state.message, style: const TextStyle(color: Colors.red)),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormulario(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}