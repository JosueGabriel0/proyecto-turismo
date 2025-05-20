import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_response.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia/familia_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia/familia_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia/familia_state.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/lugar/lugar_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/lugar/lugar_state.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/foto_widget.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/info_row_widget.dart';

class FamiliaScreen extends StatefulWidget {
  const FamiliaScreen({super.key});

  @override
  State<FamiliaScreen> createState() => _FamiliaScreenState();
}

class _FamiliaScreenState extends State<FamiliaScreen>{
  final _formKey= GlobalKey<FormState>();
  int? _idFamiliaController;
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _nombreLugarController = TextEditingController();
  File? _imagenController;
  final _searchController = TextEditingController();

  @override
  void initState(){
    super.initState();
    context.read<FamiliaBloc>().add(GetFamiliasEvent());
  }

  void _pickImage() async{
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null) setState(() => _imagenController = File(image.path));
  }

  Future<bool?> _onDismissed(BuildContext context, FamiliaResponse familia) async{
    final confirmacion = await showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: const Text("¿Confirmar eliminacion?"),
              content: Text("¿Está seguro de eliminar la familia ${familia.nombre}?"),
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
            ),
    );

    if(confirmacion == true){
      context.read<FamiliaBloc>().add(DeleteFamiliaEvent(familia.idFamilia));
    }

    return confirmacion;
  }

  void _resetForm(){
    _nombreController.clear();
    _descripcionController.clear();
    _nombreLugarController.clear();
    _imagenController = null;
  }

  void _submitForm(){
    if(_formKey.currentState!.validate()){
      final familiaDto = FamiliaDto(
          nombre: _nombreController.text,
          descripcion: _descripcionController.text,
          nombreLugar: _nombreLugarController.text
      );

      if(_idFamiliaController != null){
        context.read<FamiliaBloc>().add(PutFamiliaEvent(_idFamiliaController!, familiaDto, _imagenController));
      } else {
        context.read<FamiliaBloc>().add(PostFamiliaEvent(familiaDto, _imagenController));
      }

      _resetForm();
    }
  }

  void _cargarParaEditar(FamiliaResponse familia){
    setState(() {
      _idFamiliaController = familia.idFamilia;
      _nombreController.text = familia.nombre;
      _descripcionController.text = familia.descripcion;
    });
  }
  void _mostrarFormulario(BuildContext context){
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
                      decoration: const InputDecoration(labelText: "Descripcion"),
                    ),
                    BlocBuilder<LugarBloc, LugarState>(
                      builder: (context, lugarState) {
                        if (lugarState is LugarListLoaded) {
                          final lugares = lugarState.lugares
                              .map((l) => l.nombre)
                              .toSet()
                              .toList(); // elimina duplicados

                          // Asegúrate de que el valor actual está en la lista de items
                          final currentValue = lugares.contains(_nombreLugarController.text)
                              ? _nombreLugarController.text
                              : null;

                          return SizedBox(
                            width: 400, // Ancho fijo que puedes ajustar
                            child: DropdownButtonFormField<String>(
                              value: currentValue,
                              decoration: const InputDecoration(labelText: "Lugar"),
                              items: lugares.map((lugar) {
                                return DropdownMenuItem(
                                  value: lugar,
                                  child: SizedBox(
                                    width: 259, // Cambia esto al ancho que necesites
                                    child: Text(
                                      lugar,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _nombreLugarController.text = value!;
                                });
                              },
                              validator: (value) =>
                              value == null || value.isEmpty ? 'Campo requerido' : null,
                            ),
                          );
                        } else if (lugarState is LugarLoading) {
                          return const CircularProgressIndicator();
                        } else if (lugarState is LugarError) {
                          return Text("Error al cargar lugares: ${lugarState
                              .message}");
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 10,),
                    Column(
                      children: [
                        ElevatedButton(
                            onPressed: _pickImage,
                            child: const Text("Seleccionar imagen")
                        ),
                        if(_imagenController !=null) Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: const Text("Imagen seleccionada"),
                        ),
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
                            child: Text(_idFamiliaController == null ? "Crear" : "Actualizar")
                        ),
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
                ),
              ),
            )
            );
        },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocListener<FamiliaBloc, FamiliaState>(
          listener: (context, state) {
            if (state is FamiliaSuccess) {
              context.read<FamiliaBloc>().add(GetFamiliasEvent());
            }
          },
          child: BlocBuilder<FamiliaBloc, FamiliaState>(
            builder: (context, state) {
              if (state is FamiliaLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FamiliaListLoaded) {
                return Column(
                  children: [
                    // 🔍 Buscador
                    TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        context.read<FamiliaBloc>().add(
                          BuscarFamiliasPorNombreEvent(value),
                        );
                      },
                      decoration: const InputDecoration(
                        labelText: 'Buscar familia...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // 📋 Lista de familias
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.familiaListResponse.length,
                        itemBuilder: (context, index) {
                          final familia = state.familiaListResponse[index];
                          return Dismissible(
                            key: Key(familia.idFamilia.toString()),
                            confirmDismiss: (_) => _onDismissed(context, familia),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            child: ListTile(
                              leading: FotoWidget(fileName: familia.imagenUrl),
                              title: Text(familia.nombre),
                              subtitle: Text(familia.descripcion),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.info),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text("Información de la familia"),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: FotoWidget(fileName: familia.imagenUrl, size: 80),
                                                ),
                                                const SizedBox(height: 16),
                                                InfoRowWidget(label: "ID", value: familia.idFamilia.toString()),
                                                InfoRowWidget(label: "Nombre", value: familia.nombre),
                                                InfoRowWidget(label: "Descripción", value: familia.descripcion),
                                                InfoRowWidget(
                                                  label: "Categorías",
                                                  value: (familia.familiaCategorias ?? [])
                                                      .where((f) => f?.idFamiliaCategoria != null)
                                                      .map((f) => f!.idFamiliaCategoria!)
                                                      .join(', '),
                                                ),
                                                InfoRowWidget(label: "Fecha de creación", value: familia.fechaCreacionFamilia),
                                                InfoRowWidget(label: "Fecha de modificación", value: familia.fechaModificacionFamilia ?? "No hay modificaciones"),
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
                                      _cargarParaEditar(familia);
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
              } else if (state is FamiliaError) {
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