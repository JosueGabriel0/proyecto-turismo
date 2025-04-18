import 'dart:convert';

List<RolResponse> rolResponseFromJson(String str) => List<RolResponse>.from(json.decode(str).map((x) => RolResponse.fromJson(x)));
RolResponse rolFromJson(String str) => RolResponse.fromJson(json.decode(str));
String rolResponseToJson(List<RolResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RolResponse {
  int idRol;
  String nombre;
  List<String> usuarios;
  DateTime fechaCreacionRol;
  DateTime fechaModificacionRol;

  RolResponse({
    required this.idRol,
    required this.nombre,
    required this.usuarios,
    required this.fechaCreacionRol,
    required this.fechaModificacionRol,
  });

  factory RolResponse.fromJson(Map<String, dynamic> json) => RolResponse(
    idRol: json["idRol"],
    nombre: json["nombre"],
    usuarios: List<String>.from(json["usuarios"].map((x) => x)),
    fechaCreacionRol: DateTime.parse(json["fechaCreacionRol"]),
    fechaModificacionRol: DateTime.parse(json["fechaModificacionRol"]),
  );

  Map<String, dynamic> toJson() => {
    "idRol": idRol,
    "nombre": nombre,
    "usuarios": List<dynamic>.from(usuarios.map((x) => x)),
    "fechaCreacionRol": fechaCreacionRol.toIso8601String(),
    "fechaModificacionRol": fechaModificacionRol.toIso8601String(),
  };
}