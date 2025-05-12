import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';

class FamiliaResponse {
  int idFamilia;
  String nombre;
  String descripcion;
  String imagenUrl;
  List<CategoriaResponse>? categorias;
  String fechaCreacionFamilia;
  String? fechaModificacionFamilia;

  FamiliaResponse({
    required this.idFamilia,
    required this.nombre,
    required this.descripcion,
    required this.imagenUrl,
    required this.categorias,
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
      categorias: json['categorias'] != null
          ? (json['categorias'] as List)
          .map((e) => CategoriaResponse.fromJson(e))
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
      'emprendimientos': categorias?.map((e) => e?.toJson()).toList(),
      'fechaCreacionFamilia': fechaCreacionFamilia,
      'fechaModificacionFamilia': fechaModificacionFamilia,
    };
  }
}