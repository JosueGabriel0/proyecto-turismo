import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart' as imagePicker;
import 'package:turismo_flutter/features/admin/data/models/servicio_turistico_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/servicio_turistico_response.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/emprendimiento/emprendimiento_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/emprendimiento/emprendimiento_state.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/servicio_turistico/servicio_turistico_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/servicio_turistico/servicio_turistico_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/servicio_turistico/servicio_turistico_state.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/foto_widget.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/servicio_turistico_emprendedor_dto.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/servicio_turistico_emprendedor_response.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/servicio_turistico/servicio_turistico_emprendedor_bloc.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/servicio_turistico/servicio_turistico_emprendedor_event.dart';
import 'package:turismo_flutter/features/emprendedor/presentation/bloc/servicio_turistico/servicio_turistico_emprendedor_state.dart';

class MisServiciosScreen extends StatefulWidget {
  const MisServiciosScreen({super.key});

  @override
  State<MisServiciosScreen> createState() => _MisServiciosScreenState();
}

class _MisServiciosScreenState extends State<MisServiciosScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _servicioEditandoId;

  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _precioController = TextEditingController();
  final _tipoServicioController = TextEditingController();
  final _nombreEmprendimientoController = TextEditingController();

  File? _imagenFile;

  final _searchController = TextEditingController();

  final List<String> tiposServicios = [
    "HOTELERIA",
    "GASTRONOMIA",
    "ARTESANIA",
    "CYCLING",
    "KAYAK",
    "CULTURA",
    "PAQUETE_TURISTICO",
  ];

  String? _tipoServicioSeleccionado; // Variable para guardar la selección

  @override
  void initState() {
    super.initState();
    _nombreEmprendimientoController.text = "Hostal Estrella Andina";
    context.read<ServicioTuristicoEmprendedorBloc>().add(
        ObtenerServiciosPorIdEmprendimientoEmprendedorEvent(1)
    );

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

  Future<bool?> _onDismissed(BuildContext context, ServicioTuristicoEmprendedorResponse servicio) async {
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
      context.read<ServicioTuristicoEmprendedorBloc>().add(EliminarServicioTuristicoEmprendedorEvent(servicio.idServicio));
    }
    return confirmacion;
  }

  void _cargarParaEditar(ServicioTuristicoEmprendedorResponse servicio) {
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
      final dto = ServicioTuristicoEmprendedorDto(
        idServicio: _servicioEditandoId ?? 0,
        nombre: _nombreController.text,
        descripcion: _descripcionController.text,
        precioUnitario: double.parse(_precioController.text),
        tipoServicio: _tipoServicioController.text,
        nombreEmprendimiento: _nombreEmprendimientoController.text,
      );

      if (_servicioEditandoId != null) {
        context.read<ServicioTuristicoEmprendedorBloc>().add(ActualizarServicioTuristicoEmprendedorEvent(_servicioEditandoId!, dto, _imagenFile));
      } else {
        context.read<ServicioTuristicoEmprendedorBloc>().add(CrearServicioTuristicoEmprendedorEvent(dto, _imagenFile));
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
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Tipo de Servicio"),
                  value: _tipoServicioSeleccionado,
                  items: tiposServicios.map((tipo) {
                    return DropdownMenuItem<String>(
                      value: tipo,
                      child: Text(tipo),
                    );
                  }).toList(),
                  onChanged: (valor) {
                    setState(() {
                      _tipoServicioSeleccionado = valor;
                      _tipoServicioController.text = valor ?? '';
                    });
                  },
                  validator: (v) => v == null || v.isEmpty ? "Campo requerido" : null,
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
        child: BlocListener<ServicioTuristicoEmprendedorBloc, ServicioTuristicoEmprendedorState>(
          listener: (context, state) {
            if (state is ServicioSuccessEmprendedor) {
              context.read<ServicioTuristicoEmprendedorBloc>().add(
                  ObtenerServiciosPorIdEmprendimientoEmprendedorEvent(1)
              );
            }
          },
          child: BlocBuilder<ServicioTuristicoEmprendedorBloc, ServicioTuristicoEmprendedorState>(
            builder: (context, state) {
              if (state is ServicioLoadingEmprendedor) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ServicioListLoadedEmprendedor) {
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
                        context.read<ServicioTuristicoEmprendedorBloc>().add(BuscarServiciosPorNombreEmprendedorEvent(value));
                      },
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.servicios.length,
                        itemBuilder: (context, index) {
                          final servicio = state.servicios[index];
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
                                                    child: FotoWidget(fileName: servicio.imagenUrl, size: 80,),
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
              } else if (state is ServicioErrorEmprendedor) {
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