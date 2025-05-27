import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/admin/admin_injection.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/categoria/categoria_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/categoria/categoria_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/categoria/categoria_state.dart';
import 'package:turismo_flutter/features/general/presentation/widgets/imagen_descargada_widget.dart';

class CategoriaPorIdWidget extends StatelessWidget {
  const CategoriaPorIdWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriaGeneralBloc, CategoriaGeneralState>(
      builder: (context, state) {
        if (state is CategoriaLoadingGeneral) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoriaLoadedGeneral) {
          final categoria = state.categoria;
          return Column(
            children: [
              Expanded(
                child: ImagenDescargadaWidget(
                  fileName: categoria.imagenUrl ?? '',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                categoria.nombre ?? 'Sin nombre',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        } else if (state is CategoriaErrorGeneral) {
          return const Center(child: Icon(Icons.error));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}