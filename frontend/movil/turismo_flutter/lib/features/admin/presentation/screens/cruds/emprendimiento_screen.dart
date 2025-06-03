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

  Future<void> _pickImage(Function() setStateCallback) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imagenController = File(image.path);
      setStateCallback(); // Esto actualiza el diálogo
    }
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
      Navigator.of(context).pop();
    } else {
      // Mostrar Snackbar si el formulario NO es válido
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, completa todos los campos requeridos.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
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
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(
                          _idEmprendimientoController != null ? "Editar Emprendimiento" : "Crear Emprendimiento",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                          textAlign: TextAlign.center, // Alineación del texto
                        ),
                      ),
                      SizedBox(height: 10,),
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
                        controller: _latitudController,
                        decoration: const InputDecoration(labelText: "Latitud"),
                        validator: (v) => v!.isEmpty ? "Campo requerido" : null,
                        readOnly: true,
                      ),
                      TextFormField(
                        controller: _longitudController,
                        decoration: const InputDecoration(labelText: "Longitud"),
                        validator: (v) => v!.isEmpty ? "Campo requerido" : null,
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

                            _latitudController.text = lat.toString();
                            _longitudController.text = lng.toString();

                            setStateDialog(() {}); // Refresca el contenido del diálogo
                          }
                        },
                        child: Text(
                          (_latitudController.text.isNotEmpty &&
                              _longitudController.text.isNotEmpty)
                              ? 'Lat: ${_latitudController.text}, Lng: ${_longitudController.text}'
                              : 'Seleccionar ubicación en el mapa',
                          textAlign: TextAlign.center,
                        ),
                      ),

                      // 🔍 Mostrar minimapa si hay lat/lng
                      if (_latitudController.text.isNotEmpty &&
                          _longitudController.text.isNotEmpty) ...[
                        Builder(builder: (context) {
                          final lat = _latitudController.text;
                          final lng = _longitudController.text;

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
                        }),
                      ],

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
                                  _idFamiliaCategoriaController.text = value.toString();
                                  setStateDialog(() {});
                                },
                                validator: (value) => value == null ? 'Campo requerido' : null,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await _pickImage(() => setStateDialog(() {}));
                            },
                            child: const Text("Seleccionar Imagen"),
                          ),
                          const SizedBox(height: 10),
                          if (_imagenController == null)
                            const Text("Ninguna imagen seleccionada")
                          else
                            Center(
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    _imagenController!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
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
                            },
                            child: Text(_idEmprendimientoController == null ? "Crear" : "Actualizar"),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              _resetForm();
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancelar"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                child: ListTile(
                                  leading: FotoWidget(fileName: emprendimiento.imagenUrl ?? ""),
                                  title: Text(emprendimiento.nombre, style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),),
                                  subtitle: Text(emprendimiento.descripcion),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.info, color: Colors.blue),
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
                                                      child: FotoWidget(fileName: emprendimiento.imagenUrl ?? "", size: 80),
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
                                                  child: const Text("Cerrar"),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.edit, color: Colors.green),
                                        onPressed: () {
                                          _cargarParaEditar(emprendimiento);
                                          _mostrarFormulario(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
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