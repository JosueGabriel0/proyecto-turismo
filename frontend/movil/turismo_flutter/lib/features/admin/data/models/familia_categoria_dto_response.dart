import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';

class FamiliaCategoriaDtoResponse {
  int idFamiliaCategoria;
  int idFamilia;
  String nombreFamilia;
  int idCategoria;
  String nombreCategoria;
  List<EmprendimientoResponse>? emprendimientos;
  String fechaCreacionFamiliaCategoria;
  String? fechaModificacionFamiliaCategoria;

  FamiliaCategoriaDtoResponse({
    required this.idFamiliaCategoria,
    required this.idFamilia,
    required this.nombreFamilia,
    required this.idCategoria,
    required this.nombreCategoria,
    required this.emprendimientos,
    required this.fechaCreacionFamiliaCategoria,
    this.fechaModificacionFamiliaCategoria,
  });

  factory FamiliaCategoriaDtoResponse.fromJson(Map<String, dynamic> json) {
    return FamiliaCategoriaDtoResponse(
      idFamiliaCategoria: json['idFamiliaCategoria'],
      idFamilia: json['idFamilia'],
      nombreFamilia: json['nombreFamilia'],
      idCategoria: json['idCategoria'],
      nombreCategoria: json['nombreCategoria'],
      emprendimientos: json['emprendimientos'] != null
          ? (json['emprendimientos'] as List).map((e) => EmprendimientoResponse.fromJson(e)).toList()
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