import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_post.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_state.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia/familia_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia/familia_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia/familia_state.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia_categoria/familia_categoria_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia_categoria/familia_categoria_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia_categoria/familia_categoria_state.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/info_row_widget.dart';

class FamiliaCategoriaScreen extends StatefulWidget {
  const FamiliaCategoriaScreen({Key? key}) : super(key: key);

  @override
  State<FamiliaCategoriaScreen> createState() => _FamiliaCategoriaScreenState();
}

class _FamiliaCategoriaScreenState extends State<FamiliaCategoriaScreen> {
  String? familiaSeleccionada;

  @override
  void initState() {
    super.initState();
    context.read<FamiliaCategoriaBloc>().add(ListarRelacionesEvent());
  }

  void _mostrarFormulario(BuildContext context) {
    final familiaBloc = context.read<FamiliaBloc>();
    final categoriaBloc = context.read<CategoriaBloc>();

    familiaBloc.add(GetFamiliasEvent());
    categoriaBloc.add(GetCategoriasEvent());

    int? selectedFamiliaId;
    int? selectedCategoriaId;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Nueva relación Familia-Categoría", style: TextStyle(fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<FamiliaBloc, FamiliaState>(
                  builder: (context, state) {
                    if (state is FamiliaListLoaded) {
                      return DropdownButtonFormField<int>(
                        value: selectedFamiliaId,
                        decoration: const InputDecoration(labelText: "Familia"),
                        items: state.familiaListResponse.map((f) {
                          return DropdownMenuItem(
                            value: f.idFamilia,
                            child: Text(f.nombre),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectedFamiliaId = value;
                        },
                        validator: (v) => v == null  ? "Campo requerido" : null,
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                const SizedBox(height: 12),
                BlocBuilder<CategoriaBloc, CategoriaState>(
                  builder: (context, state) {
                    if (state is CategoriaListLoaded) {
                      return DropdownButtonFormField<int>(
                        value: selectedCategoriaId,
                        decoration: const InputDecoration(labelText: "Categoría"),
                        items: state.categorias.map((c) {
                          return DropdownMenuItem(
                            value: c.idCategoria,
                            child: Text(c.nombre),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectedCategoriaId = value;
                        },
                        validator: (v) => v == null ? "Campo requerido" : null,
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedFamiliaId != null && selectedCategoriaId != null) {
                  final dto = FamiliaCategoriaDtoPost(
                    idFamilia: selectedFamiliaId!,
                    idCategoria: selectedCategoriaId!,
                  );
                  context.read<FamiliaCategoriaBloc>().add(
                    AsociarFamiliaCategoriaEvent(dto),
                  );
                  Navigator.pop(context);
                }  else {
                  // Mostrar Snackbar si el formulario NO es válido
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Por favor, completa todos los campos requeridos.'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: const Text("Guardar"),
            ),
          ],
        );
      },
    );
  }

  void _mostrarInfoDialog(BuildContext context, dynamic relacion) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Información de ${relacion.nombreCategoria}'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoRowWidget(label: 'Familia', value: relacion.nombreFamilia),
                InfoRowWidget(label: 'Categoría', value: relacion.nombreCategoria),
                InfoRowWidget(label: 'ID Familia-Categoría', value: relacion.idFamiliaCategoria),
                const SizedBox(height: 12),
                const Text('Emprendimientos asociados:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                if (relacion.emprendimientos != null && relacion.emprendimientos.isNotEmpty)
                  ...relacion.emprendimientos.map<Widget>((emp) => ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: InfoRowWidget(label: 'Nombre', value: emp.nombre,),
                    subtitle: InfoRowWidget(label: 'Descripcion', value: emp.descripcion),
                  ))
                else
                  const Text('No hay emprendimientos asociados.'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Familias y Categorías')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<FamiliaCategoriaBloc, FamiliaCategoriaState>(
          builder: (context, state) {
            if (state is FamiliaCategoriaLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FamiliaCategoriaListLoaded) {
              final relaciones = state.familiaCategoriaListResponse;

              // Obtener las familias únicas
              final familiasUnicas = relaciones
                  .map((r) => r.nombreFamilia)
                  .toSet()
                  .toList();

              // Filtrar categorías asociadas a la familia seleccionada
              final categoriasFiltradas = familiaSeleccionada == null
                  ? []
                  : relaciones
                  .where((r) => r.nombreFamilia == familiaSeleccionada)
                  .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Selecciona una familia:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    value: familiaSeleccionada,
                    hint: const Text("Familias"),
                    isExpanded: true,
                    items: familiasUnicas.map((familia) {
                      return DropdownMenuItem(
                        value: familia,
                        child: Text(familia),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        familiaSeleccionada = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  if (familiaSeleccionada != null)
                    Expanded(
                      child: categoriasFiltradas.isEmpty
                          ? const Text("No hay categorías asociadas.")
                          : ListView.builder(
                        itemCount: categoriasFiltradas.length,
                        itemBuilder: (context, index) {
                          final relacion = categoriasFiltradas[index];

                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              title: Text(relacion.nombreCategoria),
                              subtitle: Text("ID Categoría: ${relacion.idCategoria}"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.info, color: Colors.blue),
                                    onPressed: () {
                                      _mostrarInfoDialog(context, relacion);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      final id = relacion.idFamiliaCategoria;
                                      if (id != null) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text("¿Eliminar relación?"),
                                            content: const Text("¿Estás seguro de que deseas eliminar esta relación familia-categoría?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.of(context).pop(),
                                                child: const Text("Cancelar"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(); // cerrar diálogo
                                                  context.read<FamiliaCategoriaBloc>().add(
                                                    EliminarRelacionEvent(id),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                ),
                                                child: const Text("Eliminar"),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("No se pudo obtener el ID de la relación."),
                                          ),
                                        );
                                      }
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
            } else if (state is FamiliaCategoriaError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormulario(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}