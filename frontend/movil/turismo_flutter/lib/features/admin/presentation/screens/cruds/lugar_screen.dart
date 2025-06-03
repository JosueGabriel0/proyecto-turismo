import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turismo_flutter/features/admin/data/models/lugar_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/lugar_response.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/lugar/lugar_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/lugar/lugar_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/lugar/lugar_state.dart';
import 'package:turismo_flutter/features/admin/presentation/screens/cruds/selector_ubicacion_screen.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/foto_widget.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/info_row_widget.dart';

class LugarScreen extends StatefulWidget{
  const LugarScreen({super.key});

  @override
  State<LugarScreen> createState() => _LugarScreenState();
}

class _LugarScreenState extends State<LugarScreen>{
  final _formKey = GlobalKey<FormState>();
  int? _lugarEditandoId;
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _direccionController = TextEditingController();
  final _latitudController = TextEditingController();
  final _longitudController = TextEditingController();
  File? _imagenUrlController;
  final _familiasController = TextEditingController();
  final _searchController = TextEditingController();


  @override
  void initState() {
    super.initState();

    context.read<LugarBloc>().add(GetAllLugaresEvent());

    // Listeners para refrescar el minimapa
    _latitudController.addListener(_onLatLngChanged);
    _longitudController.addListener(_onLatLngChanged);
  }

  void _onLatLngChanged() {
    // Si ambos campos no están vacíos, refresca el widget
    if (_latitudController.text.isNotEmpty && _longitudController.text.isNotEmpty) {
      setState(() {});
    }
  }

  // Listas de ejemplo
  final List<String> _paises = ['Perú'];

  final List<String> _provincias = [
    'Lima',
    'Arequipa',
    'Cusco',
    'La Libertad',
    'Piura',
    'Loreto',
    'Junín',
    'Puno',
    'Cajamarca',
    'Ica',
  ];

  final Map<String, List<String>> _ciudadesPorProvincia = {
    'Lima': ['Lima', 'Miraflores', 'San Isidro', 'Surco'],
    'Arequipa': ['Arequipa', 'Cayma', 'Yanahuara'],
    'Cusco': ['Cusco', 'Wanchaq', 'San Sebastián'],
    'La Libertad': ['Trujillo', 'El Porvenir', 'Florencia de Mora'],
    'Piura': ['Piura', 'Sullana', 'Talara'],
    'Loreto': ['Iquitos', 'Punchana', 'Belén'],
    'Junín': ['Huancayo', 'El Tambo'],
    'Puno': ['Puno', 'Juliaca', 'Capachica'],
    'Cajamarca': ['Cajamarca', 'Baños del Inca'],
    'Ica': ['Ica', 'Chincha', 'Nazca'],
  };

// Variables de selección
  String? _paisSeleccionado = 'Perú';
  String? _provinciaSeleccionada;
  String? _ciudadSeleccionada;

  @override
  void dispose() {
    _latitudController.removeListener(_onLatLngChanged);
    _longitudController.removeListener(_onLatLngChanged);

    _nombreController.dispose();
    _descripcionController.dispose();
    _direccionController.dispose();
    _latitudController.dispose();
    _longitudController.dispose();
    _familiasController.dispose();
    _searchController.dispose();

    super.dispose();
  }

  Future<void> _pickImage(Function() setStateCallback) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imagenUrlController = File(image.path);
      setStateCallback(); // Esto actualiza el diálogo
    }
  }

  Future<bool?> _onDismissed(BuildContext context, LugarResponse lugar) async {
    final confirmacion = await showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: const Text("¿Confirmar eliminacion?"),
              content: Text("¿Esta seguro de eliminar el lugar ${lugar.nombre}?"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Cancelar")
                ),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Eliminar")
                ),
              ],
            )
    );

    if(confirmacion == true){
      context.read<LugarBloc>().add(DeleteLugarEvent(lugar.idLugar));
    }

    return confirmacion;
  }

  void _cargarParaEditar(LugarResponse lugar){
    setState(() {
      _lugarEditandoId = lugar.idLugar;
      _nombreController.text = lugar.nombre;
      _descripcionController.text = lugar.descripcion;
      _direccionController.text = lugar.descripcion;
      _ciudadSeleccionada = lugar.ciudad;
      _provinciaSeleccionada = lugar.provincia;
      _paisSeleccionado = lugar.pais;
      _latitudController.text = lugar.latitud;
      _longitudController.text = lugar.longitud;
    });
  }

  void _submitForm(){
    if(_formKey.currentState!.validate()){
      final lugarDto = LugarDto(
          nombre: _nombreController.text,
          descripcion: _descripcionController.text,
          direccion: _descripcionController.text,
          ciudad: _ciudadSeleccionada!,
          provincia: _provinciaSeleccionada!,
          pais: _paisSeleccionado!,
          latitud: _latitudController.text,
          longitud: _longitudController.text,
      );

      if(_lugarEditandoId != null){
        context.read<LugarBloc>().add(PutLugarEvent(_lugarEditandoId!, lugarDto, _imagenUrlController));
      } else {
        context.read<LugarBloc>().add(PostLugarEvent(lugarDto, _imagenUrlController));
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

  void _resetForm(){
    _nombreController.clear();
    _descripcionController.clear();
    _direccionController.clear();
    _ciudadSeleccionada = null;
    _provinciaSeleccionada = null;
    _paisSeleccionado = null;
    _latitudController.clear();
    _longitudController.clear();
    _imagenUrlController = null;
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
                      Text(_lugarEditandoId != null ? "Editar Lugar" : "Crear Lugar", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: _nombreController,
                        decoration: const InputDecoration(labelText: "Nombre"),
                        validator: (v) => v!.isEmpty ? "Campo requerido" : null,
                      ),
                      TextFormField(
                        controller: _descripcionController,
                        decoration: const InputDecoration(labelText: "Descripcion"),
                        validator: (v) => v!.isEmpty ? "Campo requerido" : null,
                      ),
                      TextFormField(
                        controller: _direccionController,
                        decoration: const InputDecoration(labelText: "Direccion"),
                        validator: (v) => v!.isEmpty ? "Campo requerido" : null,
                      ),
                      DropdownButtonFormField<String>(
                        value: _paisSeleccionado,
                        items: _paises.map((pais) => DropdownMenuItem(
                          value: pais,
                          child: Text(pais),
                        )).toList(),
                        decoration: const InputDecoration(labelText: 'País'),
                        onChanged: (value) {
                          setStateDialog(() {
                            _paisSeleccionado = value;
                          });
                        },
                        validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                      ),

                      DropdownButtonFormField<String>(
                        value: _provinciaSeleccionada,
                        items: _provincias.map((provincia) => DropdownMenuItem(
                          value: provincia,
                          child: Text(provincia),
                        )).toList(),
                        decoration: const InputDecoration(labelText: 'Provincia'),
                        onChanged: (value) {
                          setStateDialog(() {
                            _provinciaSeleccionada = value;
                            _ciudadSeleccionada = null; // Limpiar ciudad para que se actualice
                          });
                        },
                        validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                      ),

                      DropdownButtonFormField<String>(
                        value: _ciudadSeleccionada,
                        items: (_ciudadesPorProvincia[_provinciaSeleccionada] ?? [])
                            .map((ciudad) => DropdownMenuItem(
                          value: ciudad,
                          child: Text(ciudad),
                        ))
                            .toList(),
                        decoration: const InputDecoration(labelText: 'Ciudad'),
                        onChanged: (value) {
                          setStateDialog(() {
                            _ciudadSeleccionada = value;
                          });
                        },
                        validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
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

                            setStateDialog(() {}); // <-- Esto actualiza el diálogo
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
                          if (_imagenUrlController == null)
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
                                    _imagenUrlController!,
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
                            child: Text(_lugarEditandoId == null ? "Crear" : "Actualizar"),
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
        child: BlocListener<LugarBloc, LugarState>(
          listener: (context, state) {
            if (state is LugarSuccess) {
              context.read<LugarBloc>().add(GetAllLugaresEvent());
            }
          },
          child: BlocBuilder<LugarBloc, LugarState>(
            builder: (context, state) {
              if (state is LugarLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LugarListLoaded) {
                return Column(
                  children: [
                    // 🟦 Buscador
                    TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        context.read<LugarBloc>().add(
                          BuscarLugaresPorNombreEvent(value),
                        );
                      },
                      decoration: const InputDecoration(
                        labelText: 'Buscar lugar...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // 🟦 Lista de lugares
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.lugares.length,
                        itemBuilder: (context, index) {
                          final lugar = state.lugares[index];
                          return Dismissible(
                            key: Key(lugar.idLugar.toString()),
                            confirmDismiss: (_) => _onDismissed(context, lugar),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            child: Card(
                              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                              elevation: 3,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                leading: FotoWidget(fileName: lugar.imagenUrl ?? ""),
                                title: Text(lugar.nombre, style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),),
                                subtitle: Text(lugar.direccion),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.info, color: Colors.blue),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: const Text("Información del lugar"),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: FotoWidget(fileName: lugar.imagenUrl ?? "", size: 80),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  InfoRowWidget(label: "ID", value: lugar.idLugar.toString()),
                                                  InfoRowWidget(label: "Nombre", value: lugar.nombre),
                                                  InfoRowWidget(label: "Descripción", value: lugar.descripcion),
                                                  InfoRowWidget(label: "Dirección", value: lugar.direccion),
                                                  InfoRowWidget(label: "Ciudad", value: lugar.ciudad),
                                                  InfoRowWidget(label: "Provincia", value: lugar.provincia),
                                                  InfoRowWidget(label: "País", value: lugar.pais),
                                                  InfoRowWidget(label: "Longitud", value: lugar.longitud.toString()),
                                                  InfoRowWidget(label: "Latitud", value: lugar.latitud.toString()),
                                                  InfoRowWidget(label: "Imagen URL", value: lugar.imagenUrl),
                                                  InfoRowWidget(
                                                    label: "Familias",
                                                    value: (lugar.familias ?? [])
                                                        .where((f) => f?.nombre != null)
                                                        .map((f) => f!.nombre!)
                                                        .join(', '),
                                                  ),
                                                  InfoRowWidget(label: "Fecha de creación", value: lugar.fechaCreacionLugar),
                                                  InfoRowWidget(label: "Fecha de modificación", value: lugar.fechaModificacionLugar.toString()),
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
                                        _cargarParaEditar(lugar);
                                        _mostrarFormulario(context);
                                      },
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
              } else if (state is LugarError) {
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