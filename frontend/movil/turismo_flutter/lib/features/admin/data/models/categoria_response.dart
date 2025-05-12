import 'emprendimiento_response.dart';

class CategoriaResponse {
  int idCategoria;
  String nombre;
  String descripcion;
  String imagenUrl;
  List<EmprendimientoResponse>? emprendimientos;
  String fechaCreacionCategoria;
  String? fechaModificacionCategoria;

  CategoriaResponse({
    required this.idCategoria,
    required this.nombre,
    required this.descripcion,
    required this.imagenUrl,
    required this.emprendimientos,
    required this.fechaCreacionCategoria,
    this.fechaModificacionCategoria,
  });

  factory CategoriaResponse.fromJson(Map<String, dynamic> json) {
    print("JSON categoria recibida: $json");
    return CategoriaResponse(
      idCategoria: json['idCategoria'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      imagenUrl: json['imagenUrl'],
      emprendimientos: json['emprendimientos'] != null
          ? (json['emprendimientos'] as List)
          .map((e) => EmprendimientoResponse.fromJson(e))
          .toList()
          : [],
      fechaCreacionCategoria: json['fechaCreacionCategoria'],
      fechaModificacionCategoria: json['fechaModificacionCategoria'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCategoria': idCategoria,
      'nombre': nombre,
      'descripcion': descripcion,
      'imagenUrl': imagenUrl,
      'emprendimientos': emprendimientos?.map((e) => e.toJson()).toList(),
      'fechaCreacionCategoria': fechaCreacionCategoria,
      'fechaModificacionCategoria': fechaModificacionCategoria,
    };
  }
}