import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_response.dart';

class FamiliaResponse {
  int idFamilia;
  String nombre;
  String descripcion;
  String? imagenUrl;
  List<FamiliaCategoriaResponse>? familiaCategorias;
  String fechaCreacionFamilia;
  String? fechaModificacionFamilia;

  FamiliaResponse({
    required this.idFamilia,
    required this.nombre,
    required this.descripcion,
    required this.imagenUrl,
    required this.familiaCategorias,
    required this.fechaCreacionFamilia,
    required this.fechaModificacionFamilia,
  });

  factory FamiliaResponse.fromJson(Map<String, dynamic> json) {
    print("JSON familia recibida: $json");
    return FamiliaResponse(
      idFamilia: json['idFamilia'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      imagenUrl: json['imagenUrl'],
      familiaCategorias: json['familiaCategorias'] != null
          ? (json['familiaCategorias'] as List)
          .map((e) => FamiliaCategoriaResponse.fromJson(e))
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