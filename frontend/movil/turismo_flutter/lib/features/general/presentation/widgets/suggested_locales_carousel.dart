import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:turismo_flutter/features/general/presentation/bloc/emprendimiento/emprendimiento_general_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/emprendimiento/emprendimiento_general_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/emprendimiento/emprendimiento_general_state.dart';
import 'package:turismo_flutter/features/general/presentation/widgets/foto_rectangulo_widget.dart';

class SuggestedLocalesCarousel extends StatelessWidget {
  const SuggestedLocalesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmprendimientoGeneralBloc, EmprendimientoGeneralState>(
      builder: (context, state) {
        if (state is EmprendimientoLoadingGeneral) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is EmprendimientoListLoadedGeneral) {
          final emprendimientos = state.emprendimientos;

          if (emprendimientos.isEmpty) {
            return const Center(child: Text("No hay emprendimientos disponibles."));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Locales sugeridos',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              cs.CarouselSlider(
                options: cs.CarouselOptions(
                  height: 330,
                  viewportFraction: 0.50,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: false,
                  padEnds: false,
                ),
                items: emprendimientos.map((empr) {
                  return Builder(
                    builder: (BuildContext context) {
                      return SizedBox(
                        width: 200,
                        height: 330,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                    child: SizedBox(
                                      height: 150,
                                      width: double.infinity,
                                      child: FotoRectanguloWidget(
                                        fileName: empr.imagenUrl ?? "",
                                        height: 150,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: SizedBox(
                                      height: 36,
                                      child: ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(Icons.star, size: 16),
                                        label: const Text(
                                          "Rate",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black54,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          minimumSize: Size.zero,
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 180,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        empr.nombre,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        empr.descripcion,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 12),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Puedes navegar a un detalle, por ejemplo
                                        },
                                        child: const Text('Ver más'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
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
                    },
                  );
                }).toList(),
              ),
            ],
          );
        } else if (state is EmprendimientoErrorGeneral) {
          return Center(child: Text(state.message));
        } else {
          // Dispara el evento si el estado es inicial
          context.read<EmprendimientoGeneralBloc>().add(GetEmprendimientosGeneralEvent());
          return const SizedBox();
        }
      },
    );
  }
}