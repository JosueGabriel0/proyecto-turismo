class CategoriaResponse {
  int idCategoria;
  String nombre;
  String descripcion;
  List<String> emprendimientos;
  DateTime fechaCreacionCategoria;
  DateTime fechaModificacionCategoria;

  CategoriaResponse({
    required this.idCategoria,
    required this.nombre,
    required this.descripcion,
    required this.emprendimientos,
    required this.fechaCreacionCategoria,
    required this.fechaModificacionCategoria,
  });

  factory CategoriaResponse.fromJson(Map<String, dynamic> json) {
    return CategoriaResponse(
      idCategoria: json['idCategoria'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      emprendimientos: List<String>.from(json['emprendimientos']),
      fechaCreacionCategoria: DateTime.parse(json['fechaCreacionCategoria']),
      fechaModificacionCategoria:
      DateTime.parse(json['fechaModificacionCategoria']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCategoria': idCategoria,
      'nombre': nombre,
      'descripcion': descripcion,
      'emprendimientos': emprendimientos,
      'fechaCreacionCategoria': fechaCreacionCategoria.toIso8601String(),
      'fechaModificacionCategoria': fechaModificacionCategoria.toIso8601String(),
    };
  }
}