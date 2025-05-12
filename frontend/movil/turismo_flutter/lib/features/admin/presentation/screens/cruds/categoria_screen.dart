import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turismo_flutter/features/admin/data/models/categoria_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_response.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_state.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia/familia_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia/familia_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia/familia_state.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/lugar/lugar_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/lugar/lugar_state.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/foto_widget.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/info_row_widget.dart';

class CategoriaScreen extends StatefulWidget {
  const CategoriaScreen({super.key});

  @override
  State<CategoriaScreen> createState() => _CategoriaScreenState();
}

class _CategoriaScreenState extends State<CategoriaScreen>{
  final _formKey= GlobalKey<FormState>();
  int? _idCategoriaController;
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _nombreFamiliaController = TextEditingController();
  File? _imagenController;

  @override
  void initState(){
    super.initState();
    context.read<CategoriaBloc>().add(GetCategoriasEvent());
  }

  void _pickImage() async{
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null) setState(() => _imagenController = File(image.path));
  }

  Future<bool?> _onDismissed(BuildContext context, CategoriaResponse categoria) async{
    final confirmacion = await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text("¿Confirmar eliminacion?"),
            content: Text("¿Está seguro de eliminar la familia ${categoria.nombre}?"),
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
      context.read<CategoriaBloc>().add(DeleteCategoriaEvent(categoria.idCategoria));
    }

    return confirmacion;
  }

  void _resetForm(){
    _nombreController.clear();
    _descripcionController.clear();
    _nombreFamiliaController.clear();
    _imagenController = null;
  }

  void _submitForm(){
    if(_formKey.currentState!.validate()){
      final categoriaDto = CategoriaDto(
          nombre: _nombreController.text,
          descripcion: _descripcionController.text,
          nombreFamilia: _nombreFamiliaController.text
      );

      if(_idCategoriaController != null){
        context.read<CategoriaBloc>().add(PutCategoriaEvent(_idCategoriaController!, categoriaDto, _imagenController));
      } else {
        context.read<CategoriaBloc>().add(PostCategoriaEvent(categoriaDto, _imagenController));
      }

      _resetForm();
    }
  }

  void _cargarParaEditar(CategoriaResponse categoria){
    setState(() {
      _idCategoriaController = categoria.idCategoria;
      _nombreController.text = categoria.nombre;
      _descripcionController.text = categoria.descripcion;
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
                    BlocBuilder<FamiliaBloc, FamiliaState>(
                      builder: (context, familiaState) {
                        if (familiaState is FamiliaListLoaded) {
                          final familias = familiaState.familiaListResponse
                              .map((f) => f.nombre)
                              .toSet()
                              .toList(); // elimina duplicados

                          // Asegúrate de que el valor actual está en la lista de items
                          final currentValue = familias.contains(_nombreFamiliaController.text)
                              ? _nombreFamiliaController.text
                              : null;

                          return SizedBox(
                            width: 400, // Ancho fijo que puedes ajustar
                            child: DropdownButtonFormField<String>(
                              value: currentValue,
                              decoration: const InputDecoration(labelText: "Familia"),
                              items: familias.map((familia) {
                                return DropdownMenuItem(
                                  value: familia,
                                  child: SizedBox(
                                    width: 259, // Cambia esto al ancho que necesites
                                    child: Text(
                                      familia,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _nombreFamiliaController.text = value!;
                                });
                              },
                              validator: (value) =>
                              value == null || value.isEmpty ? 'Campo requerido' : null,
                            ),
                          );
                        } else if (familiaState is FamiliaLoading) {
                          return const CircularProgressIndicator();
                        } else if (familiaState is FamiliaError) {
                          return Text("Error al cargar familias: ${familiaState
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
                            child: Text(_idCategoriaController == null ? "Crear" : "Actualizar")
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
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocListener<CategoriaBloc, CategoriaState>(
          listener: (context, state){
            if(state is CategoriaSuccess){
              context.read<CategoriaBloc>().add(GetCategoriasEvent());
            }
          },
          child: BlocBuilder<CategoriaBloc, CategoriaState>(
              builder: (context, state){
                if(state is CategoriaLoading){
                  return const Center(child: CircularProgressIndicator(),);
                } else if(state is CategoriaListLoaded){
                  return ListView.builder(
                      itemCount: state.categorias.length,
                      itemBuilder: (context, index){
                        final categoria = state.categorias[index];
                        return Dismissible(
                            key: Key(categoria.idCategoria.toString()),
                            confirmDismiss: (_) => _onDismissed(context, categoria),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(Icons.delete, color: Colors.white,),
                            ),
                            child: ListTile(
                              leading: FotoWidget(fileName: categoria.imagenUrl),
                              title: Text(categoria.nombre),
                              subtitle: Text(categoria.descripcion),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.info),
                                      onPressed: (){
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: const Text("Informacion de la Categoria"),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: FotoWidget(fileName: categoria.imagenUrl, size: 80,),
                                                    ),
                                                    const SizedBox(height: 16,),
                                                    InfoRowWidget(label: "ID", value: categoria.idCategoria.toString()),
                                                    InfoRowWidget(label: "Nombre", value: categoria.nombre),
                                                    InfoRowWidget(label: "Descripcion", value: categoria.descripcion),
                                                    InfoRowWidget(
                                                      label: "Emprendimientos",
                                                      value: (categoria.emprendimientos ?? [])
                                                          .where((f) => f?.nombre != null) // Filtra nulos
                                                          .map((f) => f!.nombre!)         // Accede con confianza
                                                          .join(', '),
                                                    ),
                                                    InfoRowWidget(label: "Fecha de creacion", value: categoria.fechaCreacionCategoria),
                                                    InfoRowWidget(label: "Fecha de modificacion", value: categoria.fechaModificacionCategoria ?? "No hay modificaciones"),
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
                                      }
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: (){
                                      _cargarParaEditar(categoria);
                                      _mostrarFormulario(context);
                                    },
                                  )
                                ],
                              ),
                            )
                        );
                      }
                  );
                } else if(state is CategoriaError){
                  return Text(
                    state.message, style: const TextStyle(color: Colors.red),
                  );
                }
                return const SizedBox.shrink();
              }
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>{
          _mostrarFormulario(context)
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}