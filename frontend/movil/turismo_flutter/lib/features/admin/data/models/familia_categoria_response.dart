import 'emprendimiento_response.dart';

class FamiliaCategoriaResponse {
  int idFamiliaCategoria;

  // Lista de emprendimientos
  List<EmprendimientoResponse>? emprendimientos;

  // Fechas
  String fechaCreacionFamiliaCategoria;
  String? fechaModificacionFamiliaCategoria;

  FamiliaCategoriaResponse({
    required this.idFamiliaCategoria,
    required this.emprendimientos,
    required this.fechaCreacionFamiliaCategoria,
    this.fechaModificacionFamiliaCategoria,
  });

  factory FamiliaCategoriaResponse.fromJson(Map<String, dynamic> json) {
    return FamiliaCategoriaResponse(
      idFamiliaCategoria: json['idFamiliaCategoria'],
      emprendimientos: json['emprendimientos'] != null
          ? (json['emprendimientos'] as List)
          .map((e) => EmprendimientoResponse.fromJson(e))
          .toList()
          : [],
      fechaCreacionFamiliaCategoria: json['fechaCreacionFamiliaCategoria'],
      fechaModificacionFamiliaCategoria: json['fechaModificacionFamiliaCategoria'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idFamiliaCategoria': idFamiliaCategoria,
      'emprendimientos': emprendimientos?.map((e) => e.toJson()).toList(),
      'fechaCreacionFamiliaCategoria': fechaCreacionFamiliaCategoria,
      'fechaModificacionFamiliaCategoria': fechaModificacionFamiliaCategoria,
    };
  }
}