import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_response.dart';
import 'package:turismo_flutter/features/general/data/models/familia_categoria_general_response.dart';

class FamiliaGeneralResponse {
  int idFamilia;
  String nombre;
  String descripcion;
  String? imagenUrl;
  List<FamiliaCategoriaGeneralResponse>? familiaCategorias;
  String fechaCreacionFamilia;
  String? fechaModificacionFamilia;

  FamiliaGeneralResponse({
    required this.idFamilia,
    required this.nombre,
    required this.descripcion,
    required this.imagenUrl,
    required this.familiaCategorias,
    required this.fechaCreacionFamilia,
    required this.fechaModificacionFamilia,
  });

  factory FamiliaGeneralResponse.fromJson(Map<String, dynamic> json) {
    print("JSON familia recibida: $json");
    return FamiliaGeneralResponse(
      idFamilia: json['idFamilia'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      imagenUrl: json['imagenUrl'],
      familiaCategorias: json['familiaCategorias'] != null
          ? (json['familiaCategorias'] as List)
          .map((e) => FamiliaCategoriaGeneralResponse.fromJson(e))
          .toList()
          : [],
      fechaCreacionFamilia: json['fechaCreacionFamilia'],
      fechaModificacionFamilia: json['fechaModificacionFamilia'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idFamilia': idFamilia,
      'nombre': nombre,
      'descripcion': descripcion,
      'imagenUrl': imagenUrl,
      'familiaCategorias': familiaCategorias?.map((e) => e.toJson()).toList(),
      'fechaCreacionFamilia': fechaCreacionFamilia,
      'fechaModificacionFamilia': fechaModificacionFamilia,
    };
  }
}