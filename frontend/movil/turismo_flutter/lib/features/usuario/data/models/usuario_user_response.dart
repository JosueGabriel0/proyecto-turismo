import 'package:turismo_flutter/features/admin/data/models/authority_response.dart';
import 'package:turismo_flutter/features/admin/data/models/persona_response.dart';
import 'package:turismo_flutter/features/admin/data/models/rol_response.dart';

class UsuarioUserResponse {
  int idUsuario;
  String? username;
  String? password;
  String? estado;
  RolResponse? rol;
  PersonaResponse? persona;
  List<String?> bitacoraAccesoList;
  List<String?> noticias;
  List<String?> resenas;
  List<String?> reservas;
  String? fechaCreacionUsuario;
  String? fechaModificacionUsuario;

  UsuarioUserResponse({
    required this.idUsuario,
    required this.username,
    required this.password,
    required this.estado,
    required this.rol,
    required this.persona,
    required this.bitacoraAccesoList,
    required this.noticias,
    required this.resenas,
    required this.reservas,
    required this.fechaCreacionUsuario,
    required this.fechaModificacionUsuario,
  });

  factory UsuarioUserResponse.fromJson(Map<String, dynamic> json) {
    print("JSON usuario recibido: $json");
    return UsuarioUserResponse(
      idUsuario: json['idUsuario'],
      username: json['username'],
      password: json['password'],
      estado: json['estado'],
      rol: RolResponse.fromJson(json['rol']),
      persona: PersonaResponse.fromJson(json['persona']),
      bitacoraAccesoList: List<String>.from(json['bitacoraAccesoList']),
      noticias: List<String>.from(json['noticias']),
      resenas: List<String>.from(json['resenas']),
      reservas: List<String>.from(json['reservas']),
      fechaCreacionUsuario: json['fechaCreacionUsuario'],
      fechaModificacionUsuario: json['fechaModificacionUsuario'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUsuario': idUsuario,
      'username': username,
      'password': password,
      'estado': estado,
      'rol': rol?.toJson(),
      'persona': persona?.toJson(),
      'bitacoraAccesoList': bitacoraAccesoList,
      'noticias': noticias,
      'resenas': resenas,
      'reservas': reservas,
      'fechaCreacionUsuario': fechaCreacionUsuario,
      'fechaModificacionUsuario': fechaModificacionUsuario,
    };
  }
}