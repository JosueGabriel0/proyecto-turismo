import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';

class FamiliaResponse {
  int id;
  String nombre;
  String descripcion;
  String imagenUrl;
  String lugar;
  List<EmprendimientoResponse> emprendimientos;
  DateTime fechaCreacionFamilia;
  DateTime fechaModificacionFamilia;

  FamiliaResponse({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.imagenUrl,
    required this.lugar,
    required this.emprendimientos,
    required this.fechaCreacionFamilia,
    required this.fechaModificacionFamilia,
  });

  factory FamiliaResponse.fromJson(Map<String, dynamic> json) {
    return FamiliaResponse(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      imagenUrl: json['imagenUrl'],
      lugar: json['lugar'],
      emprendimientos: (json['emprendimientos'] as List)
          .map((e) => EmprendimientoResponse.fromJson(e))
          .toList(),
      fechaCreacionFamilia: DateTime.parse(json['fechaCreacionFamilia']),
      fechaModificacionFamilia: DateTime.parse(json['fechaModificacionFamilia']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'imagenUrl': imagenUrl,
      'lugar': lugar,
      'emprendimientos': emprendimientos.map((e) => e.toJson()).toList(),
      'fechaCreacionFamilia': fechaCreacionFamilia.toIso8601String(),
      'fechaModificacionFamilia': fechaModificacionFamilia.toIso8601String(),
    };
  }
}