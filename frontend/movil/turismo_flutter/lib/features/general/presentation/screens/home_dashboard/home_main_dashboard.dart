import 'package:flutter/material.dart';
import 'package:turismo_flutter/features/general/presentation/widgets/CustomProgressCard.dart';

class HomeMainDashboard extends StatefulWidget {
  const HomeMainDashboard({super.key});

  @override
  _HomeMainDashboardState createState() => _HomeMainDashboardState();
}

class _HomeMainDashboardState extends State<HomeMainDashboard> {
  final double progress = 0.1; // 10%

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con imagen y texto
            const SizedBox(height: 5),
            Row(
              children: [
                // Foto de perfil circular
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    'https://ejemplo.com/usuario.jpg', // Reemplaza con una URL válida
                  ),
                ),
                const SizedBox(width: 16),
                // Textos: título y subtítulo
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bienvenido, Usuario',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Descubre lo único',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            // Tarjeta de progreso
            CustomProgressCard(
              title: "Conoce todo a tu alrededor",
              subtitle: "Descubre joyas ocultas en cada lugar",
              progressPercent: 100, // Muestra 10%
              onMapPressed: () => print("Mapa"),
            ),
          ],
        ),
      ),
    );
  }
}