import 'dart:convert';

List<RolResponse> rolResponseFromJson(String str) =>
    List<RolResponse>.from(json.decode(str).map((x) => RolResponse.fromJson(x)));

String rolResponseToJson(List<RolResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RolResponse {
  int idRol;
  String nombre;
  DateTime fechaCreacionRol;
  DateTime? fechaModificacionRol;

  RolResponse({
    required this.idRol,
    required this.nombre,
    required this.fechaCreacionRol,
    this.fechaModificacionRol,
  });

  factory RolResponse.fromJson(Map<String, dynamic> json) => RolResponse(
    idRol: json["idRol"],
    nombre: json["nombre"],
    fechaCreacionRol: DateTime.parse(json["fechaCreacionRol"]),
    fechaModificacionRol: json["fechaModificacionRol"] == null
        ? null
        : DateTime.parse(json["fechaModificacionRol"]),
  );

  Map<String, dynamic> toJson() => {
    "idRol": idRol,
    "nombre": nombre,
    "fechaCreacionRol": fechaCreacionRol.toIso8601String(),
    "fechaModificacionRol": fechaModificacionRol?.toIso8601String(),
  };
}