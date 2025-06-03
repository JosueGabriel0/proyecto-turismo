import 'package:flutter/material.dart';
import 'package:turismo_flutter/features/general/data/models/familia_general_response.dart';
import 'package:turismo_flutter/features/general/presentation/widgets/foto_rectangulo_widget.dart';

class FamiliaLugarCardWidget extends StatelessWidget {
  final FamiliaGeneralResponse familia;
  final void Function(FamiliaGeneralResponse familia1)? onCardTap;
  final void Function(FamiliaGeneralResponse familia1)? onExploraPressed;

  const FamiliaLugarCardWidget({
    Key? key,
    required this.familia,
    this.onCardTap,
    this.onExploraPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onCardTap?.call(familia),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen superior
                FotoRectanguloWidget(
                  fileName: familia.imagenUrl ?? "",
                  height: 180,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),

                // Título y descripción
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        familia.nombre,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        familia.descripcion,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Botón "Explora" en la esquina superior derecha
            Positioned(
              top: 8,
              right: 8,
              child: ElevatedButton.icon(
                onPressed: () => onExploraPressed?.call(familia),
                icon: const Icon(Icons.explore, size: 16, color: Colors.black),
                label: const Text(
                  "Explora",
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  elevation: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}