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
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_state.dart';
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
  final _ciudadController = TextEditingController();
  final _provinciaController = TextEditingController();
  final _paisController = TextEditingController();
  final _latitudController = TextEditingController();
  final _longitudController = TextEditingController();
  File? _imagenUrlController;
  final _familiasController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<LugarBloc>().add(GetAllLugaresEvent());
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null) setState(() => _imagenUrlController = File(image.path));
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
      _ciudadController.text = lugar.ciudad;
      _provinciaController.text = lugar.provincia;
      _paisController.text = lugar.pais;
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
          ciudad: _ciudadController.text,
          provincia: _provinciaController.text,
          pais: _paisController.text,
          latitud: _latitudController.text,
          longitud: _longitudController.text,
      );

      if(_lugarEditandoId != null){
        context.read<LugarBloc>().add(PutLugarEvent(_lugarEditandoId!, lugarDto, _imagenUrlController));
      } else {
        context.read<LugarBloc>().add(PostLugarEvent(lugarDto, _imagenUrlController));
      }

      _resetForm();
    }
  }

  void _resetForm(){
    _nombreController.clear();
    _descripcionController.clear();
    _direccionController.clear();
    _ciudadController.clear();
    _provinciaController.clear();
    _paisController.clear();
    _latitudController.clear();
    _longitudController.clear();
    _imagenUrlController = null;
  }

  void _mostrarFormulario(BuildContext context){
    showDialog(context: context,
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
                        validator: (v) => v!.isEmpty ? "Campo requerido": null,
                      ),
                      TextFormField(
                        controller: _descripcionController,
                        decoration: const InputDecoration(labelText: "Descripcion"),
                        validator: (v) => v!.isEmpty ? "Campo requerido": null,
                      ),
                      TextFormField(
                        controller: _direccionController,
                        decoration: const InputDecoration(labelText: "Direccion"),
                        validator: (v) => v!.isEmpty ? "Campo requerido": null,
                      ),
                      TextFormField(
                        controller: _ciudadController,
                        decoration: const InputDecoration(labelText: "Ciudad"),
                        validator: (v) => v!.isEmpty ? "Campo requerido": null,
                      ),
                      TextFormField(
                        controller: _provinciaController,
                        decoration: const InputDecoration(labelText: "Provincia"),
                        validator: (v) => v!.isEmpty ? "Campo requerido": null,
                      ),
                      TextFormField(
                        controller: _paisController,
                        decoration: const InputDecoration(labelText: "Pais"),
                        validator: (v) => v!.isEmpty ? "Campo requerido": null,
                      ),
                      TextFormField(
                        controller: _latitudController,
                        decoration: const InputDecoration(labelText: "Latitud"),
                        validator: (v) => v!.isEmpty ? "Campo requerido": null,
                      ),
                      TextFormField(
                        controller: _longitudController,
                        decoration: const InputDecoration(labelText: "Longitud"),
                        validator: (v) => v!.isEmpty ? "Campo requerido": null,
                      ),
                      const SizedBox(height: 10,),
                      Column(
                        children: [
                          ElevatedButton(
                              onPressed: _pickImage,
                              child: const Text("Seleccionar Imagen"),
                          ),
                          if(_imagenUrlController != null) Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text("Imagen seleccionada"),
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: (){
                                _submitForm();
                                Navigator.of(context).pop();
                                },
                              child: Text(_lugarEditandoId == null ? "Crear" : "Actualizar")
                          ),
                          const SizedBox(width: 8,),
                          OutlinedButton(
                              onPressed: (){
                                _resetForm();
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cancelar")
                          ),
                        ],
                      )
                    ],
                  )
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocListener<LugarBloc, LugarState>(
            listener: (context, state){
              if(state is LugarSuccess){
                context.read<LugarBloc>().add(GetAllLugaresEvent());
              }
              },
            child: BlocBuilder<LugarBloc, LugarState>(
                builder: (context, state) {
                  if(state is LugarLoading){
                    return const Center(child: CircularProgressIndicator(),);
                  } else if(state is LugarListLoaded){
                    return ListView.builder(
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
                                child: Icon(Icons.delete, color: Colors.white,),
                              ),
                              child: ListTile(
                                leading: FotoWidget(
                                  fileName: lugar.imagenUrl
                                ),
                                title: Text(lugar.nombre),
                                subtitle: Text(lugar.direccion),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.info),
                                      onPressed: (){
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: const Text("Informacion del lugar"),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: FotoWidget(
                                                        fileName: lugar.imagenUrl,
                                                        size: 80,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 16,),
                                                    InfoRowWidget(label: "ID", value: lugar.idLugar.toString()),
                                                    InfoRowWidget(label: "Nombre", value: lugar.nombre),
                                                    InfoRowWidget(label: "descripcion", value: lugar.descripcion),
                                                    InfoRowWidget(label: "direccion", value: lugar.direccion),
                                                    InfoRowWidget(label: "ciudad", value: lugar.ciudad),
                                                    InfoRowWidget(label: "provincia", value: lugar.provincia),
                                                    InfoRowWidget(label: "pais", value: lugar.pais),
                                                    InfoRowWidget(label: "longitud", value: lugar.longitud.toString()),
                                                    InfoRowWidget(label: "imagenUrl", value: lugar.latitud.toString()),
                                                    InfoRowWidget(label: "imagenUrl", value: lugar.imagenUrl.toString()),
                                                    InfoRowWidget(
                                                      label: "Familias",
                                                      value: (lugar.familias ?? [])
                                                          .where((f) => f?.nombre != null) // Filtra nulos
                                                          .map((f) => f!.nombre!)         // Accede con confianza
                                                          .join(', '),
                                                    ),
                                                    InfoRowWidget(label: "fechaCreacionLugar", value: lugar.fechaCreacionLugar),
                                                    InfoRowWidget(label: "fechaModificacionLugar", value: lugar.fechaModificacionLugar.toString()),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () => Navigator.of(context).pop(),
                                                    child: const Text("Cerrar"))
                                              ],
                                            )
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: (){
                                        _cargarParaEditar(lugar);
                                        _mostrarFormulario(context);
                                      }, )
                                  ],
                                ),
                              ),
                          );
                        },
                        );
                  } else if(state is LugarError){
                    return Text(
                      state.message, style: const TextStyle(color: Colors.red),
                    );
                  }
                  return const SizedBox.shrink();
                },
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
            _mostrarFormulario(context)
          },
          child: const Icon(Icons.add),
      ),
    );
  }
}