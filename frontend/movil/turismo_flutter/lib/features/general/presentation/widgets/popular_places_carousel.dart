import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:turismo_flutter/features/general/presentation/bloc/lugar/lugar_general_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/lugar/lugar_general_state.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/lugar/lugar_general_event.dart';
import 'package:turismo_flutter/features/general/data/models/lugar_general_response.dart';
import 'package:turismo_flutter/features/general/presentation/widgets/foto_rectangulo_widget.dart';

class PopularPlacesCarousel extends StatelessWidget {
  final void Function(LugarGeneralResponse lugar)? onExplorarPressed;
  final void Function(LugarGeneralResponse lugar)? onRatePressed;
  final void Function(LugarGeneralResponse lugar)? onCardTapped;

  const PopularPlacesCarousel({
    Key? key,
    this.onExplorarPressed,
    this.onRatePressed,
    this.onCardTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LugarGeneralBloc, LugarGeneralState>(
      builder: (context, state) {
        if (state is LugarLoadingGeneral) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LugarListLoadedGeneral) {
          final lugares = state.lugares;

          if (lugares.isEmpty) {
            return const Center(child: Text("No hay lugares disponibles."));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Los lugares más populares',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              cs.CarouselSlider(
                options: cs.CarouselOptions(
                  height: 260,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                ),
                items: lugares.map((lugar) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () => onCardTapped?.call(lugar),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 130,
                                    child: FotoRectanguloWidget(
                                      fileName: lugar.imagenUrl ?? "",
                                      height: 130,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  left: 8,
                                  child: ElevatedButton.icon(
                                    onPressed: () => onExplorarPressed?.call(lugar),
                                    icon: const Icon(Icons.explore, size: 16, color: Colors.white),
                                    label: const Text("Explora", style: TextStyle(fontSize: 12, color: Colors.white)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black54,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: ElevatedButton.icon(
                                    onPressed: () => onRatePressed?.call(lugar),
                                    icon: const Icon(Icons.star_rate, size: 16, color: Colors.white),
                                    label: const Text("Rate", style: TextStyle(fontSize: 12, color: Colors.white)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black54,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lugar.nombre,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    lugar.descripcion,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          );
        } else if (state is LugarErrorGeneral) {
          return Center(child: Text(state.message));
        } else {
          // Inicializa el evento al mostrar el widget
          context.read<LugarGeneralBloc>().add(GetAllLugaresGeneralEvent());
          return const SizedBox();
        }
      },
    );
  }
}