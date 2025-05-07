class RolResponse {
  int idRol;
  String nombre;
  String fechaCreacionRol;
  String? fechaModificacionRol;

  RolResponse({
    required this.idRol,
    required this.nombre,
    required this.fechaCreacionRol,
    required this.fechaModificacionRol,
  });

  factory RolResponse.fromJson(Map<String, dynamic> json) {
    print("JSON rol recibido: $json");
    return RolResponse(
      idRol: json['idRol'],
      nombre: json['nombre'] ?? '',
      fechaCreacionRol: json['fechaCreacionRol'] ?? '',
      fechaModificacionRol: json['fechaModificacionRol'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idRol': idRol,
      'nombre': nombre,
      'fechaCreacionRol': fechaCreacionRol,
      'fechaModificacionRol': fechaModificacionRol,
    };
  }
}