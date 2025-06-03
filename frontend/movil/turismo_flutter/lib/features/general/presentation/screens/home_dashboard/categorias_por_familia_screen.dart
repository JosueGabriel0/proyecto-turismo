import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/familia_categoria/familia_categoria_general_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/familia_categoria/familia_categoria_general_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/familia_categoria/familia_categoria_general_state.dart';
import 'package:turismo_flutter/features/general/data/models/familia_categoria_general_dto_response.dart';
import 'package:turismo_flutter/features/general/data/models/categoria_general_response.dart';
import 'package:turismo_flutter/features/general/domain/usecases/categoria/get_categoria_by_id_usecase_general.dart';
import 'package:turismo_flutter/features/general/presentation/widgets/imagen_descargada_widget.dart';

class CategoriasPorFamiliaScreen extends StatefulWidget {
  final Function(int newIndex, {int? id}) onNavigate;
  final int? idFamilia;
  final Function(int newIndex) onNavigateIndex;

  const CategoriasPorFamiliaScreen({Key? key, required this.onNavigate, required this.idFamilia, required this.onNavigateIndex}) : super(key: key);

  @override
  State<CategoriasPorFamiliaScreen> createState() => _CategoriasPorFamiliaScreenState();
}

class _CategoriasPorFamiliaScreenState extends State<CategoriasPorFamiliaScreen> {
  final getCategoriaByIdUsecaseGeneral = GetIt.I<GetCategoriaByIdUsecaseGeneral>();

  @override
  void initState() {
    super.initState();
    if (widget.idFamilia != null) {
      print("ID enviado al backend desde initState: ${widget.idFamilia}");
      context.read<FamiliaCategoriaGeneralBloc>().add(
        ObtenerPorIdFamiliaEventGeneral(widget.idFamilia!),
      );
    }
  }

  @override
  void didUpdateWidget(covariant CategoriasPorFamiliaScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.idFamilia != widget.idFamilia && widget.idFamilia != null) {
      print("ID actualizado enviado al backend desde didUpdateWidget: ${widget.idFamilia}");
      context.read<FamiliaCategoriaGeneralBloc>().add(
        ObtenerPorIdFamiliaEventGeneral(widget.idFamilia!),
      );
    }
  }

  Future<CategoriaGeneralResponse> obtenerCategoria(int idCategoria) async {
    return await getCategoriaByIdUsecaseGeneral(idCategoria);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          widget.onNavigateIndex(1);
        },
        ),
      ),
      body: BlocBuilder<FamiliaCategoriaGeneralBloc, FamiliaCategoriaGeneralState>(
        builder: (context, state) {
          if (state is FamiliaCategoriaLoadingGeneral) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FamiliaCategoriaListLoadedGeneral) {
            final categorias = state.familiaCategoriaGeneralListResponse;

            print('UI - Recibí estado con ${categorias.length} categorías, IDs: ${categorias.map((e) => e.idFamiliaCategoria).toList()}');
            // 🔽 Agrega este print para mostrar los IDs
            for (var item in categorias) {
              print('ID de categoría: ${item.idCategoria}, ID familia-categoría: ${item.idFamiliaCategoria}');
            }

            if (categorias.isEmpty) {
              return const Center(child: Text("No hay categorías asociadas."));
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.65,  // MÁS ALTO que antes
              ),
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                final item = categorias[index] as FamiliaCategoriaGeneralDtoResponse;

                return FutureBuilder<CategoriaGeneralResponse>(
                  future: obtenerCategoria(item.idCategoria),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Card(
                        child: Center(child: Text("Error al cargar categoría")),
                      );
                    } else if (snapshot.hasData) {
                      final categoria = snapshot.data!;
                      return InkWell(
                        onTap: () {
                          print("Id de familiaCategoria ${item.idFamiliaCategoria}");
                          widget.onNavigate(3, id: item.idFamiliaCategoria);
                        },
                        borderRadius: BorderRadius.circular(12), // Para mantener el redondeo
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 6,
                                child: categoria.imagenUrl != null
                                    ? ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                  child: ImagenDescargadaWidget(
                                    fileName: categoria.imagenUrl ?? "",
                                    fit: BoxFit.contain,
                                  ),
                                )
                                    : Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                  ),
                                  child: const Icon(Icons.image_not_supported, size: 50),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        categoria.nombre,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Flexible(
                                        child: Text(
                                          categoria.descripcion,
                                          style: const TextStyle(fontSize: 14, color: Colors.black54),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Card(child: Center(child: Text("Categoría no disponible.")));
                    }
                  },
                );
              },
            );
          } else if (state is FamiliaCategoriaErrorGeneral) {
            return Center(child: Text("Error: ${state.message}"));
          }

          return const SizedBox.shrink(); // Estado inicial o desconocido
        },
      ),
    );
  }
}