import 'package:flutter/material.dart';

class CustomProgressCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int progressPercent; // valor entre 0 y 100
  final VoidCallback onMapPressed;

  const CustomProgressCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progressPercent,
    required this.onMapPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Convertimos el valor de 0-100 a 0.0-1.0 para el cálculo interno
    final double progress = (progressPercent.clamp(0, 100)) / 100;

    return Card(
      // resto igual
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          // ... aquí va el contenido igual ...
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            const SizedBox(height: 10),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final fullWidth = constraints.maxWidth;
                      final progressWidth = fullWidth * progress;
                      const indicatorWidth = 2.0;

                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: progressWidth > indicatorWidth ? progressWidth - indicatorWidth : 0,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Color(0xFF0AA3EF),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                  ),
                                ),
                              ),
                              Container(
                                width: indicatorWidth,
                                height: 10,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          Positioned(
                            left: progressWidth - 12,
                            bottom: 18,
                            child: Image.asset(
                              'assets/images/hiking.png',
                              width: 24,
                              height: 24,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Text("$progressPercent%"),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: onMapPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF5AC7F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.black), // Borde negro
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        "Mapa",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.map, color: Colors.black), // Icono a la derecha
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}