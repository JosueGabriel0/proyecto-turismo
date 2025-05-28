import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DashboardEmprendedorScreen extends StatelessWidget {
  const DashboardEmprendedorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Emprendedor"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildStatCard("Mis Servicios", "12", Icons.design_services),
                _buildStatCard("Mis Reservas", "34", Icons.book_online),
                _buildStatCard("Reseñas Recibidas", "98", Icons.reviews),
              ],
            ).animate().fade(duration: 600.ms).moveY(),
            const SizedBox(height: 32),
            Text("Reservas por Estado", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            AspectRatio(
              aspectRatio: 1.5,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    _barGroup(0, 10), // Pendientes
                    _barGroup(1, 18), // Confirmadas
                    _barGroup(2, 6),  // Canceladas
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const titles = ["Pend.", "Conf.", "Canc."];
                          return Text(titles[value.toInt()]);
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ).animate().fade().scale(delay: 300.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.teal, size: 32),
          const SizedBox(height: 8),
          Text(value, style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(label, style: GoogleFonts.lato(fontSize: 14)),
        ],
      ),
    );
  }

  BarChartGroupData _barGroup(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(toY: y, color: Colors.teal, width: 20, borderRadius: BorderRadius.circular(4))
    ]);
  }
}