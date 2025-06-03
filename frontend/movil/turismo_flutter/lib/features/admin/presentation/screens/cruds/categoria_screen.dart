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
  File? _imagenController;
  final _searchController = TextEditingController();

  @override
  void initState(){
    super.initState();
    context.read<CategoriaBloc>().add(GetCategoriasEvent());
  }

  Future<void> _pickImage(Function() setStateCallback) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imagenController = File(image.path);
      setStateCallback(); // Esto actualiza el diálogo
    }
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
    _imagenController = null;
  }

  void _submitForm(){
    if(_formKey.currentState!.validate()){
      final categoriaDto = CategoriaDto(
          nombre: _nombreController.text,
          descripcion: _descripcionController.text,
      );

      if(_idCategoriaController != null){
        context.read<CategoriaBloc>().add(PutCategoriaEvent(_idCategoriaController!, categoriaDto, _imagenController));
      } else {
        context.read<CategoriaBloc>().add(PostCategoriaEvent(categoriaDto, _imagenController));
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

  void _cargarParaEditar(CategoriaResponse categoria){
    setState(() {
      _idCategoriaController = categoria.idCategoria;
      _nombreController.text = categoria.nombre;
      _descripcionController.text = categoria.descripcion;
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
                      Text(_idCategoriaController != null ? "Editar Categoria" : "Crear Categoria", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
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
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await _pickImage(() {
                                setStateDialog(() {});  // Actualizas el estado local del diálogo
                              });
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
                            child: Text(_idCategoriaController == null ? "Crear" : "Actualizar"),
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
        child: BlocListener<CategoriaBloc, CategoriaState>(
          listener: (context, state) {
            if (state is CategoriaSuccess) {
              context.read<CategoriaBloc>().add(GetCategoriasEvent());
            }
          },
          child: BlocBuilder<CategoriaBloc, CategoriaState>(
            builder: (context, state) {
              if (state is CategoriaLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CategoriaListLoaded) {
                return Column(
                  children: [
                    // 🔍 Buscador
                    TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        context.read<CategoriaBloc>().add(
                          BuscarCategoriasPorNombreEvent(value),
                        );
                      },
                      decoration: const InputDecoration(
                        labelText: 'Buscar categoría...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // 📋 Lista de categorías
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.categorias.length,
                        itemBuilder: (context, index) {
                          final categoria = state.categorias[index];
                          return Dismissible(
                            key: Key(categoria.idCategoria.toString()),
                            confirmDismiss: (_) => _onDismissed(context, categoria),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            child: Card(
                              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                              elevation: 3,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    FotoWidget(fileName: categoria.imagenUrl ?? "", size: 60),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            categoria.nombre,
                                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            categoria.descripcion,
                                            style: const TextStyle(color: Colors.grey),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
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
                                                title: const Text("Información de la Categoría"),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Center(
                                                        child: FotoWidget(fileName: categoria.imagenUrl ?? "", size: 80),
                                                      ),
                                                      const SizedBox(height: 16),
                                                      InfoRowWidget(label: "ID", value: categoria.idCategoria.toString()),
                                                      InfoRowWidget(label: "Nombre", value: categoria.nombre),
                                                      InfoRowWidget(label: "Descripción", value: categoria.descripcion),
                                                      InfoRowWidget(label: "Fecha de creación", value: categoria.fechaCreacionCategoria),
                                                      InfoRowWidget(label: "Fecha de modificación", value: categoria.fechaModificacionCategoria ?? "No hay modificaciones"),
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
                                            _cargarParaEditar(categoria);
                                            _mostrarFormulario(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              } else if (state is CategoriaError) {
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