import 'package:turismo_flutter/features/admin/data/models/authority_response.dart';
import 'package:turismo_flutter/features/admin/data/models/persona_response.dart';
import 'package:turismo_flutter/features/admin/data/models/rol_response.dart';
import 'package:turismo_flutter/features/usuario/data/models/reserva_user_response.dart';

class UsuarioEmprendedorResponse {
  int idUsuario;
  String? username;
  String? password;
  String? estado;
  RolResponse? rol;
  PersonaResponse? persona;
  List<String?> bitacoraAccesoList;
  List<String?> noticias;
  List<String?> resenas;
  List<ReservaUserResponse?> reservas;
  String? fechaCreacionUsuario;
  String? fechaModificacionUsuario;

  UsuarioEmprendedorResponse({
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

  factory UsuarioEmprendedorResponse.fromJson(Map<String, dynamic> json) {
    print("JSON usuario recibido: $json");
    return UsuarioEmprendedorResponse(
      idUsuario: json['idUsuario'],
      username: json['username'],
      password: json['password'],
      estado: json['estado'],
      rol: json['rol'] != null ? RolResponse.fromJson(json['rol']) : null,
      persona: json['persona'] != null ? PersonaResponse.fromJson(json['persona']) : null,
      bitacoraAccesoList: json['bitacoraAccesoList'] != null
          ? List<String>.from(json['bitacoraAccesoList'])
          : [],
      noticias: json['noticias'] != null ? List<String>.from(json['noticias']) : [],
      resenas: json['resenas'] != null ? List<String>.from(json['resenas']) : [],
      reservas: json['reservas'] != null
          ? (json['reservas'] as List<dynamic>)
          .map((e) => ReservaUserResponse.fromJson(e))
          .toList()
          : [],
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