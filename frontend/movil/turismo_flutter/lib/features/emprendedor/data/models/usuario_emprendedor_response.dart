import 'package:turismo_flutter/features/admin/data/models/authority_response.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';
import 'package:turismo_flutter/features/admin/data/models/persona_response.dart';
import 'package:turismo_flutter/features/admin/data/models/reserva_response.dart';
import 'package:turismo_flutter/features/admin/data/models/rol_response.dart';

class UsuarioEmprendedorResponse {
  int idUsuario;
  String? username;
  String? password;
  String? estado;
  RolResponse? rol;
  EmprendimientoResponse? emprendimiento;
  PersonaResponse? persona;
  List<String?> bitacoraAccesoList;
  List<String?> noticias;
  List<String?> resenas;
  List<ReservaResponse?> reservas;
  bool? enabled;
  bool? accountNonLocked;
  bool? accountNonExpired;
  bool? credentialsNonExpired;
  List<AuthorityResponse?>? authorities;

  String? fechaCreacionUsuario;
  String? fechaModificacionUsuario;

  UsuarioEmprendedorResponse({
    required this.idUsuario,
    required this.username,
    required this.password,
    required this.estado,
    required this.rol,
    required this.emprendimiento,
    required this.persona,
    required this.bitacoraAccesoList,
    required this.noticias,
    required this.resenas,
    required this.reservas,
    required this.fechaCreacionUsuario,
    required this.fechaModificacionUsuario,
    this.enabled,
    this.authorities,
    this.accountNonLocked,
    this.accountNonExpired,
    this.credentialsNonExpired,
  });

  factory UsuarioEmprendedorResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError("json is null");
    }

    return UsuarioEmprendedorResponse(
      idUsuario: json['idUsuario'] ?? 0,
      username: json['username'],
      password: json['password'],
      estado: json['estado'],
      rol: json['rol'] != null ? RolResponse.fromJson(json['rol']) : null,
      emprendimiento: json['emprendimiento'] != null
          ? EmprendimientoResponse.fromJson(json['emprendimiento'])
          : null,
      persona: json['persona'] != null
          ? PersonaResponse.fromJson(json['persona'])
          : null,
      bitacoraAccesoList: (json['bitacoraAccesoList'] as List<dynamic>?)
          ?.map((e) => e?.toString())
          .toList() ??
          [],
      noticias: (json['noticias'] as List<dynamic>?)
          ?.map((e) => e?.toString())
          .toList() ??
          [],
      resenas: (json['resenas'] as List<dynamic>?)
          ?.map((e) => e?.toString())
          .toList() ??
          [],
      reservas: (json['reservas'] as List<dynamic>?)
          ?.map((e) => e == null
          ? null
          : ReservaResponse.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      fechaCreacionUsuario: json['fechaCreacionUsuario'],
      fechaModificacionUsuario: json['fechaModificacionUsuario'],
      enabled: json['enabled'],
      accountNonLocked: json['accountNonLocked'],
      accountNonExpired: json['accountNonExpired'],
      credentialsNonExpired: json['credentialsNonExpired'],
      authorities: (json['authorities'] as List<dynamic>?)
          ?.map((e) => e == null
          ? null
          : AuthorityResponse.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
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
      'authorities': authorities?.map((e) => e?.toJson()).toList(),
      'enabled': enabled,
      'accountNonLocked': accountNonLocked,
      'accountNonExpired': accountNonExpired,
      'credentialsNonExpired': credentialsNonExpired,
    };
  }
}