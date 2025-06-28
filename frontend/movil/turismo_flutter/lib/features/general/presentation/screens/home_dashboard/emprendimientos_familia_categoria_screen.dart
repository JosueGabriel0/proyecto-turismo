import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/familia_categoria/familia_categoria_general_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/familia_categoria/familia_categoria_general_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/familia_categoria/familia_categoria_general_state.dart';
import 'package:turismo_flutter/features/general/presentation/widgets/foto_rectangulo_widget.dart';
import 'package:turismo_flutter/features/general/data/models/emprendimiento_general_response.dart';

class EmprendimientosFamiliaCategoriaScreen extends StatefulWidget {
  final Function(int newIndex, {int? id}) onNavigate;
  final int? idFamiliaCategoria;
  final Function(int newIndex) onNavigateIndex;

  const EmprendimientosFamiliaCategoriaScreen({
    Key? key,
    required this.onNavigate,
    required this.idFamiliaCategoria,
    required this.onNavigateIndex
  }) : super(key: key);

  @override
  State<EmprendimientosFamiliaCategoriaScreen> createState() =>
      _EmprendimientosFamiliaCategoriaScreenState();
}

class _EmprendimientosFamiliaCategoriaScreenState
    extends State<EmprendimientosFamiliaCategoriaScreen> {
  @override
  void initState() {
    super.initState();
    final id = widget.idFamiliaCategoria;
    if (id != null) {
      context.read<FamiliaCategoriaGeneralBloc>().add(
        GetEmprendimientosPorFamiliaCategoriaEvent(id),
      );
    } else {
      // Opcional: mostrar un error, redirigir, o hacer algo por defecto
      debugPrint('idFamiliaCategoria es null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emprendimientos"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            widget.onNavigateIndex(2);
          },
        ),
      ),
      body: BlocBuilder<FamiliaCategoriaGeneralBloc, FamiliaCategoriaGeneralState>(
        builder: (context, state) {
          if (state is FamiliaCategoriaLoadingGeneral) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EmprendimientosPorFamiliaCategoriaLoadedGeneral) {
            final List<EmprendimientoGeneralResponse> emprendimientos = state.emprendimientos;

            if (emprendimientos.isEmpty) {
              return const Center(child: Text("No hay emprendimientos disponibles."));
            }

            return ListView.builder(
              itemCount: emprendimientos.length,
              itemBuilder: (context, index) {
                final e = emprendimientos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      print("Id de emprendimiento: ${e.idEmprendimiento}");
                      widget.onNavigate(4, id: e.idEmprendimiento);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FotoRectanguloWidget(
                          fileName: e.imagenUrl ?? "",
                          height: 160,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.nombre,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                e.descripcion,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is FamiliaCategoriaErrorGeneral) {
            return Center(child: Text("Error: ${state.message}"));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}