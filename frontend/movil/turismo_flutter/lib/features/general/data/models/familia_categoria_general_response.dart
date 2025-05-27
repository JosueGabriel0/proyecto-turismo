import 'package:turismo_flutter/features/general/data/models/emprendimiento_general_response.dart';

class FamiliaCategoriaGeneralResponse {
  int idFamiliaCategoria;

  // Lista de emprendimientos
  List<EmprendimientoGeneralResponse>? emprendimientos;

  // Fechas
  String fechaCreacionFamiliaCategoria;
  String? fechaModificacionFamiliaCategoria;

  FamiliaCategoriaGeneralResponse({
    required this.idFamiliaCategoria,
    required this.emprendimientos,
    required this.fechaCreacionFamiliaCategoria,
    this.fechaModificacionFamiliaCategoria,
  });

  factory FamiliaCategoriaGeneralResponse.fromJson(Map<String, dynamic> json) {
    return FamiliaCategoriaGeneralResponse(
      idFamiliaCategoria: json['idFamiliaCategoria'],
      emprendimientos: json['emprendimientos'] != null
          ? (json['emprendimientos'] as List)
          .map((e) => EmprendimientoGeneralResponse.fromJson(e))
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