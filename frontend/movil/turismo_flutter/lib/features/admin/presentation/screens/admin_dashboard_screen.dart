import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Admin"),
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
                _buildStatCard("Usuarios", "124", Icons.people),
                _buildStatCard("Reservas", "87", Icons.book_online),
                _buildStatCard("Emprendimientos", "56", Icons.store),
                _buildStatCard("Reseñas", "210", Icons.reviews),
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
                    _barGroup(0, 25),
                    _barGroup(1, 35),
                    _barGroup(2, 27),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const titles = ["Pendi..", "Confir..", "Cancel.."];
                          return Text(titles[value.toInt()]);
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ).animate().fade().scale(delay: 300.ms),
            const SizedBox(height: 32),
            Text("Emprendimientos por Categoría", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            AspectRatio(
              aspectRatio: 1.5,
              child: PieChart(
                PieChartData(
                  sections: [
                    _pieSection("Ecoturismo", 40, Colors.green),
                    _pieSection("Aventura", 30, Colors.blue),
                    _pieSection("Cultura", 20, Colors.orange),
                    _pieSection("Relax", 10, Colors.purple),
                  ],
                ),
              ),
            ).animate().fade().scale(delay: 600.ms),
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
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue, size: 32),
          const SizedBox(height: 8),
          Text(value, style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(label, style: GoogleFonts.lato(fontSize: 14)),
        ],
      ),
    );
  }

  BarChartGroupData _barGroup(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(toY: y, color: Colors.blue, width: 20, borderRadius: BorderRadius.circular(4))
    ]);
  }

  PieChartSectionData _pieSection(String title, double value, Color color) {
    return PieChartSectionData(
      value: value,
      title: title,
      color: color,
      radius: 60,
      titleStyle: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
    );
  }
}