class DashboardAdminResponse {
  final int totalUsuarios;
  final int totalReservas;
  final int totalEmprendimientos;
  final int totalResenas;
  final Map<String, int> reservasPorEstado;
  final Map<String, int> emprendimientosPorCategoria;

  DashboardAdminResponse({
    required this.totalUsuarios,
    required this.totalReservas,
    required this.totalEmprendimientos,
    required this.totalResenas,
    required this.reservasPorEstado,
    required this.emprendimientosPorCategoria,
  });

  factory DashboardAdminResponse.fromJson(Map<String, dynamic> json) {
    // Convierte los mapas dinámicos a Map<String, int>
    Map<String, int> parseMap(Map<String, dynamic>? map) {
      if (map == null) return {};
      return map.map((key, value) => MapEntry(key, value as int));
    }

    return DashboardAdminResponse(
      totalUsuarios: json['totalUsuarios'] as int,
      totalReservas: json['totalReservas'] as int,
      totalEmprendimientos: json['totalEmprendimientos'] as int,
      totalResenas: json['totalResenas'] as int,
      reservasPorEstado: parseMap(json['reservasPorEstado'] as Map<String, dynamic>?),
      emprendimientosPorCategoria: parseMap(json['emprendimientosPorCategoria'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalUsuarios': totalUsuarios,
      'totalReservas': totalReservas,
      'totalEmprendimientos': totalEmprendimientos,
      'totalResenas': totalResenas,
      'reservasPorEstado': reservasPorEstado,
      'emprendimientosPorCategoria': emprendimientosPorCategoria,
    };
  }
}