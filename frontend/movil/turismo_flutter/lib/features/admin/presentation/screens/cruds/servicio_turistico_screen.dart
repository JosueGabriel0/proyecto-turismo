import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turismo_flutter/features/admin/data/models/servicio_turistico_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/servicio_turistico_response.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_state.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/emprendimiento/emprendimiento_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/emprendimiento/emprendimiento_state.dart';
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
    context.read<ServicioTuristicoBloc>().add(GetAllServiciosTuristicosEvent());
    context.read<CategoriaBloc>().add(GetCategoriasEvent()); // 👈
  }

  Future<void> _pickImage(Function() setStateCallback) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imagenFile = File(image.path);
      setStateCallback(); // Esto actualiza el diálogo
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
                      Text(_servicioEditandoId != null ? "Editar Servicio" : "Crear Servicio", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25), textAlign: TextAlign.center,),
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
                        controller: _precioController,
                        decoration: const InputDecoration(labelText: "Precio Unitario"),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            // Reemplaza la coma por punto mientras el usuario escribe
                            final newText = newValue.text.replaceAll(',', '.');
                            return TextEditingValue(
                              text: newText,
                              selection: TextSelection.collapsed(offset: newText.length),
                            );
                          }),
                        ],
                        validator: (v) {
                          if (v == null || v.isEmpty) return "Campo requerido";
                          final number = double.tryParse(v.replaceAll(',', '.'));
                          if (number == null) return "Ingrese un número válido";
                          return null;
                        },
                      ),
                      BlocBuilder<CategoriaBloc, CategoriaState>(
                        builder: (context, state) {
                          if (state is CategoriaListLoaded) {
                            final categorias = state.categorias;

                            return DropdownButtonFormField<String>(
                              decoration: const InputDecoration(labelText: "Tipo de Servicio"),
                              value: _tipoServicioSeleccionado,
                              items: categorias.map((categoria) {
                                return DropdownMenuItem<String>(
                                  value: categoria.nombre, // Asegúrate que 'nombre' sea la propiedad correcta
                                  child: Text(categoria.nombre),
                                );
                              }).toList(),
                              onChanged: (valor) {
                                setStateDialog(() {
                                  _tipoServicioSeleccionado = valor;
                                  _tipoServicioController.text = valor ?? '';
                                });
                              },
                              validator: (v) => v == null || v.isEmpty ? "Campo requerido" : null,
                            );
                          } else if (state is CategoriaLoading) {
                            return const CircularProgressIndicator();
                          } else if (state is CategoriaError) {
                            return Text('Error al cargar categorías: ${state.message}');
                          }

                          return const SizedBox(); // Por defecto
                        },
                      ),
                      BlocBuilder<EmprendimientoBloc, EmprendimientoState>(
                        builder: (context, emprendimientoState) {
                          if (emprendimientoState is EmprendimientoListLoaded) {
                            final emprendimientos = emprendimientoState.emprendimientos
                                .map((e) => e.nombre)
                                .toSet()
                                .toList();

                            final currentValue = emprendimientos.contains(_nombreEmprendimientoController.text)
                                ? _nombreEmprendimientoController.text
                                : null;

                            return SizedBox(
                              width: 400,
                              child: DropdownButtonFormField<String>(
                                value: currentValue,
                                decoration: const InputDecoration(labelText: "Emprendimiento"),
                                items: emprendimientos.map((emprendimiento) {
                                  return DropdownMenuItem(
                                    value: emprendimiento,
                                    child: SizedBox(
                                      width: 259,
                                      child: Text(
                                        emprendimiento,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setStateDialog(() {
                                    _nombreEmprendimientoController.text = value!;
                                  });
                                },
                                validator: (value) =>
                                value == null || value.isEmpty ? 'Campo requerido' : null,
                              ),
                            );
                          } else if (emprendimientoState is EmprendimientoLoading) {
                            return const CircularProgressIndicator();
                          } else if (emprendimientoState is EmprendimientoError) {
                            return Text("Error al cargar emprendimientos: ${emprendimientoState.message}");
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
                          if (_imagenFile == null)
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
                                    _imagenFile!,
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
                            child: Card(
                              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    servicio.imagenUrl != null
                                        ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: FotoWidget(
                                        fileName: servicio.imagenUrl ?? "",
                                        size: 60,
                                      ),
                                    )
                                        : const Icon(Icons.image_not_supported, size: 60),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            servicio.nombre,
                                            style: const TextStyle(
                                                fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            servicio.descripcion,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            "Precio: ${servicio.precioUnitario}",
                                            style: const TextStyle(fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.info, color: Colors.blue),
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
                                                          child: FotoWidget(
                                                              fileName: servicio.imagenUrl ?? "", size: 80),
                                                        ),
                                                      const SizedBox(height: 16),
                                                      Text("ID: ${servicio.idServicio}"),
                                                      Text("Nombre: ${servicio.nombre}"),
                                                      Text("Descripción: ${servicio.descripcion}"),
                                                      Text("Precio Unitario: ${servicio.precioUnitario}"),
                                                      Text("Tipo Servicio: ${servicio.tipoServicio}"),
                                                      Text("Fecha creación: ${servicio.fechaCreacion}"),
                                                      Text(
                                                          "Fecha modificación: ${servicio.fechaModificacion ?? '-'}"),
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
                                          icon: const Icon(Icons.edit, color: Colors.green),
                                          onPressed: () {
                                            _cargarParaEditar(servicio);
                                            _mostrarFormulario(context);
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
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