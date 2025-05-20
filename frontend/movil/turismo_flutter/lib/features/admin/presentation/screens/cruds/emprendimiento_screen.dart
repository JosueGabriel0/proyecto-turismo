import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/emprendimiento/emprendimiento_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/emprendimiento/emprendimiento_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/emprendimiento/emprendimiento_state.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia_categoria/familia_categoria_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia_categoria/familia_categoria_state.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/cruds/selector_ubicacion_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/foto_widget.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/info_row_widget.dart';

class EmprendimientoScreen extends StatefulWidget {
  const EmprendimientoScreen({super.key});

  @override
  State<EmprendimientoScreen> createState() => _EmprendimientoScreenState();
}

class _EmprendimientoScreenState extends State<EmprendimientoScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _idEmprendimientoController;
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _latitudController = TextEditingController();
  final _longitudController = TextEditingController();
  final _idFamiliaCategoriaController = TextEditingController();
  final _searchController = TextEditingController();
  File? _imagenController;

  @override
  void initState() {
    super.initState();
    context.read<EmprendimientoBloc>().add(GetEmprendimientosEvent());
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => _imagenController = File(image.path));
  }

  Future<bool?> _onDismissed(BuildContext context, EmprendimientoResponse emprendimiento) async {
    final confirmacion = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("¿Confirmar eliminación?"),
        content: Text("¿Está seguro de eliminar el emprendimiento ${emprendimiento.nombre}?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancelar")),
          TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Eliminar")),
        ],
      ),
    );

    if (confirmacion == true) {
      context.read<EmprendimientoBloc>().add(DeleteEmprendimientoEvent(emprendimiento.idEmprendimiento));
    }

    return confirmacion;
  }

  void _resetForm() {
    _nombreController.clear();
    _descripcionController.clear();
    _latitudController.clear();
    _longitudController.clear();
    _idFamiliaCategoriaController.clear();
    _imagenController = null;
    _idEmprendimientoController = null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final emprendimientoDto = EmprendimientoDto(
        nombre: _nombreController.text,
        descripcion: _descripcionController.text,
        latitud: _latitudController.text,
        longitud: _longitudController.text,
        idFamiliaCategoria: int.parse(_idFamiliaCategoriaController.text),
      );

      if (_idEmprendimientoController != null) {
        context.read<EmprendimientoBloc>().add(PutEmprendimientoEvent(_idEmprendimientoController!, emprendimientoDto, _imagenController));
      } else {
        context.read<EmprendimientoBloc>().add(PostEmprendimientoEvent(emprendimientoDto, _imagenController));
      }

      _resetForm();
    }
  }

  void _cargarParaEditar(EmprendimientoResponse emprendimiento) {
    setState(() {
      _idEmprendimientoController = emprendimiento.idEmprendimiento;
      _nombreController.text = emprendimiento.nombre;
      _descripcionController.text = emprendimiento.descripcion;
      _latitudController.text = emprendimiento.latitud;
      _longitudController.text = emprendimiento.longitud;
      _descripcionController.text = emprendimiento.descripcion;
    });
  }

  void _mostrarFormulario(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _nombreController,
                      decoration: const InputDecoration(labelText: "Nombre"),
                    ),
                    TextFormField(
                      controller: _descripcionController,
                      decoration: const InputDecoration(labelText: "Descripción"),
                    ),
                    TextFormField(
                      controller: _latitudController,
                      decoration: const InputDecoration(labelText: "Latitud"),
                      readOnly: true,
                    ),
                    TextFormField(
                      controller: _longitudController,
                      decoration: const InputDecoration(labelText: "Longitud"),
                      readOnly: true,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final resultado = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SeleccionUbicacionScreen(),
                          ),
                        );

                        if (resultado != null) {
                          final lat = resultado['lat'] as double;
                          final lng = resultado['lng'] as double;

                          setState(() {
                            _latitudController.text = lat.toString();
                            _longitudController.text = lng.toString();
                          });
                        }
                      },
                      child: Text(
                        (_latitudController.text.isNotEmpty && _longitudController.text.isNotEmpty)
                            ? 'Lat: ${_latitudController.text}, Lng: ${_longitudController.text}'
                            : 'Seleccionar ubicación en el mapa',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    BlocBuilder<FamiliaCategoriaBloc, FamiliaCategoriaState>(
                      builder: (context, familiaCategoriaState) {
                        if (familiaCategoriaState is FamiliaCategoriaListLoaded) {
                          final familiasCategorias = familiaCategoriaState.familiaCategoriaListResponse;

                          final currentValue = int.tryParse(_idFamiliaCategoriaController.text);

                          return SizedBox(
                            width: 400,
                            child: DropdownButtonFormField<int>(
                              value: currentValue,
                              decoration: const InputDecoration(labelText: "Familia categoría"),
                              items: familiasCategorias.map((f) {
                                return DropdownMenuItem<int>(
                                  value: f.idFamiliaCategoria,
                                  child: SizedBox(
                                    width: 259,
                                    child: Text(
                                      '${f.nombreFamilia} - ${f.nombreCategoria}',
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _idFamiliaCategoriaController.text = value.toString();
                                });
                              },
                              validator: (value) =>
                              value == null ? 'Campo requerido' : null,
                            ),
                          );
                        } else if (familiaCategoriaState is FamiliaCategoriaLoading) {
                          return const CircularProgressIndicator();
                        } else if (familiaCategoriaState is FamiliaCategoriaError) {
                          return Text("Error al cargar familias con categorías: ${familiaCategoriaState.message}");
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        ElevatedButton(
                            onPressed: _pickImage,
                            child: const Text("Seleccionar imagen")),
                        if (_imagenController != null)
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("Imagen seleccionada"),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              _submitForm();
                              Navigator.of(context).pop();
                            },
                            child: Text(_idEmprendimientoController == null ? "Crear" : "Actualizar")),
                        OutlinedButton(
                            onPressed: () {
                              _resetForm();
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancelar")),
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocListener<EmprendimientoBloc, EmprendimientoState>(
          listener: (context, state) {
            if (state is EmprendimientoSuccess) {
              context.read<EmprendimientoBloc>().add(GetEmprendimientosEvent());
            }
          },
          child: BlocBuilder<EmprendimientoBloc, EmprendimientoState>(
            builder: (context, state) {
              if (state is EmprendimientoLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is EmprendimientoListLoaded) {
                return Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        context.read<EmprendimientoBloc>().add(
                          BuscarEmprendimientosPorNombreEvent(value),
                        );
                      },
                      decoration: const InputDecoration(
                        labelText: 'Buscar emprendimiento...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.emprendimientos.length,
                        itemBuilder: (context, index) {
                          final emprendimiento = state.emprendimientos[index];
                          return Dismissible(
                            key: Key(emprendimiento.idEmprendimiento.toString()),
                            confirmDismiss: (_) => _onDismissed(context, emprendimiento),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            child: ListTile(
                              leading: FotoWidget(fileName: emprendimiento.imagenUrl),
                              title: Text(emprendimiento.nombre),
                              subtitle: Text(emprendimiento.descripcion),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      icon: const Icon(Icons.info),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: const Text("Información del Emprendimiento"),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: FotoWidget(fileName: emprendimiento.imagenUrl, size: 80),
                                                    ),
                                                    const SizedBox(height: 16),
                                                    InfoRowWidget(label: "ID", value: emprendimiento.idEmprendimiento.toString()),
                                                    InfoRowWidget(label: "Nombre", value: emprendimiento.nombre),
                                                    InfoRowWidget(label: "Descripción", value: emprendimiento.descripcion),
                                                    InfoRowWidget(label: "Fecha de creación", value: emprendimiento.fechaCreacionEmprendimiento),
                                                    InfoRowWidget(label: "Fecha de modificación", value: emprendimiento.fechaModificacionEmprendimiento ?? "No hay modificaciones"),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () => Navigator.of(context).pop(),
                                                    child: const Text("Cerrar"))
                                              ],
                                            ));
                                      }),
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      _cargarParaEditar(emprendimiento);
                                      _mostrarFormulario(context);
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (state is EmprendimientoError) {
                return Text(state.message, style: const TextStyle(color: Colors.red));
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