import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/dashboard/dashboard_admin_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/dashboard/dashboard_admin_state.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Admin"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<DashboardAdminBloc, DashboardAdminState>(
          builder: (context, state) {
            if (state is DashboardAdminLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DashboardAdminLoaded) {
              final dashboard = state.dashboard;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        _buildStatCard("Usuarios", dashboard.totalUsuarios.toString(), Icons.people),
                        _buildStatCard("Reservas", dashboard.totalReservas.toString(), Icons.book_online),
                        _buildStatCard("Emprendimientos", dashboard.totalEmprendimientos.toString(), Icons.store),
                        _buildStatCard("Reseñas", dashboard.totalResenas.toString(), Icons.reviews),
                      ],
                    ).animate().fade(duration: 600.ms).moveY(),
                    const SizedBox(height: 32),
                    Text("Reservas por Estado", style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: BarChart(
                        BarChartData(
                          barGroups: _buildBarGroupsFromMap(dashboard.reservasPorEstado),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final keys = dashboard.reservasPorEstado.keys.toList();
                                  if (value.toInt() < keys.length) {
                                    return Text(keys[value.toInt()]);
                                  }
                                  return const Text('');
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
                      aspectRatio: 1.2,
                      child: PieChart(
                        PieChartData(
                          sections: _buildPieSectionsFromMap(dashboard.emprendimientosPorCategoria),
                        ),
                      ),
                    ).animate().fade().scale(delay: 600.ms),
                  ],
                ),
              );
            } else if (state is DashboardAdminError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
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
        boxShadow: const [
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

  List<BarChartGroupData> _buildBarGroupsFromMap(Map<String, int> map) {
    int i = 0;
    return map.entries.map((entry) {
      final value = entry.value.toDouble();
      return BarChartGroupData(
        x: i++,
        barRods: [
          BarChartRodData(toY: value, color: Colors.blue, width: 20, borderRadius: BorderRadius.circular(4)),
        ],
      );
    }).toList();
  }

  List<PieChartSectionData> _buildPieSectionsFromMap(Map<String, int> map) {
    final colors = [Colors.green, Colors.blue, Colors.orange, Colors.purple, Colors.red, Colors.cyan];
    final total = map.values.fold<int>(0, (sum, item) => sum + item);
    final entries = map.entries.toList();

    return List.generate(entries.length, (i) {
      final entry = entries[i];
      final percent = total == 0 ? 0.0 : (entry.value / total) * 100;

      return PieChartSectionData(
        value: entry.value.toDouble(),
        title: '${entry.key} (${percent.toStringAsFixed(1)}%)',
        color: colors[i % colors.length],
        radius: 100, // 👈 Aumenta el tamaño del círculo completo
        titleStyle: GoogleFonts.lato(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          shadows: [
            Shadow(
              blurRadius: 2,
              color: Colors.black,
              offset: Offset(0, 0),
            )
          ],
        ),
      );
    });
  }
}