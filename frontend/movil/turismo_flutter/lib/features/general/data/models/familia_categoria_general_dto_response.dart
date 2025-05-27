import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';
import 'package:turismo_flutter/features/general/data/models/emprendimiento_general_response.dart';

class FamiliaCategoriaGeneralDtoResponse {
  int idFamiliaCategoria;
  int idFamilia;
  String nombreFamilia;
  int idCategoria;
  String nombreCategoria;
  List<EmprendimientoGeneralResponse>? emprendimientos;
  String fechaCreacionFamiliaCategoria;
  String? fechaModificacionFamiliaCategoria;

  FamiliaCategoriaGeneralDtoResponse({
    required this.idFamiliaCategoria,
    required this.idFamilia,
    required this.nombreFamilia,
    required this.idCategoria,
    required this.nombreCategoria,
    required this.emprendimientos,
    required this.fechaCreacionFamiliaCategoria,
    this.fechaModificacionFamiliaCategoria,
  });

  factory FamiliaCategoriaGeneralDtoResponse.fromJson(Map<String, dynamic> json) {
    return FamiliaCategoriaGeneralDtoResponse(
      idFamiliaCategoria: json['idFamiliaCategoria'],
      idFamilia: json['idFamilia'],
      nombreFamilia: json['nombreFamilia'],
      idCategoria: json['idCategoria'],
      nombreCategoria: json['nombreCategoria'],
      emprendimientos: json['emprendimientos'] != null
          ? (json['emprendimientos'] as List).map((e) => EmprendimientoGeneralResponse.fromJson(e)).toList()
          : null,
      fechaCreacionFamiliaCategoria: json['fechaCreacionFamiliaCategoria'],
      fechaModificacionFamiliaCategoria: json['fechaModificacionFamiliaCategoria'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idFamiliaCategoria': idFamiliaCategoria,
      'idFamilia': idFamilia,
      'nombreFamilia': nombreFamilia,
      'idCategoria': idCategoria,
      'nombreCategoria': nombreCategoria,
      'emprendimientos': emprendimientos?.map((e) => e?.toJson()).toList(),
      'fechaCreacionFamiliaCategoria': fechaCreacionFamiliaCategoria,
      'fechaModificacionFamiliaCategoria': fechaModificacionFamiliaCategoria,
    };
  }
}