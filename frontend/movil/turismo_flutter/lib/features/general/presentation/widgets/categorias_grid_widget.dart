import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/categoria/categoria_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/categoria/categoria_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/categoria/categoria_state.dart';
import 'package:turismo_flutter/features/general/presentation/widgets/foto_rectangulo_widget.dart';

class CategoriasGridWidget extends StatelessWidget {
  const CategoriasGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriaGeneralBloc, CategoriaGeneralState>(
      builder: (context, state) {
        if (state is CategoriaLoadingGeneral) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoriaListLoadedGeneral) {
          final categorias = state.categorias;

          if (categorias.isEmpty) {
            return const Center(child: Text("No hay categorías disponibles."));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Categorías',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.85,
                ),
                itemCount: categorias.length,
                itemBuilder: (context, index) {
                  final categoria = categorias[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: FotoRectanguloWidget(
                            fileName: categoria.imagenUrl ?? "",
                            height: 70,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        categoria.nombre,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                },
              ),
            ],
          );

        } else if (state is CategoriaErrorGeneral) {
          return Center(child: Text(state.message));
        } else {
          context.read<CategoriaGeneralBloc>().add(GetCategoriasGeneralEvent());
          return const SizedBox();
        }
      },
    );
  }
}