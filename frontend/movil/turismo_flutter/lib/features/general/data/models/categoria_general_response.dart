import 'emprendimiento_general_response.dart';

class CategoriaGeneralResponse {
  int idCategoria;
  String nombre;
  String descripcion;
  String? imagenUrl;
  String fechaCreacionCategoria;
  String? fechaModificacionCategoria;

  CategoriaGeneralResponse({
    required this.idCategoria,
    required this.nombre,
    required this.descripcion,
    required this.imagenUrl,
    required this.fechaCreacionCategoria,
    this.fechaModificacionCategoria,
  });

  factory CategoriaGeneralResponse.fromJson(Map<String, dynamic> json) {
    print("JSON categoria recibida: $json");
    return CategoriaGeneralResponse(
      idCategoria: json['idCategoria'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      imagenUrl: json['imagenUrl'],
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
      'fechaCreacionCategoria': fechaCreacionCategoria,
      'fechaModificacionCategoria': fechaModificacionCategoria,
    };
  }
}