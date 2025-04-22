import 'dart:convert';
import 'package:turismo_flutter/data/models/usuario_completo_dto.dart';

List<UsuarioCompletoResponse> usuarioCompletoResponseFromList(List<dynamic> list) =>
    list.map((x) => UsuarioCompletoResponse.fromJson(x)).toList();

UsuarioCompletoResponse usuarioFromJson(String str) =>
    UsuarioCompletoResponse.fromJson(json.decode(str));

String usuarioCompletoResponseToJson(List<UsuarioCompletoResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsuarioCompletoResponse {
  int idUsuario;
  String username;
  String password;
  String estado;
  Rol rol;
  Persona persona;
  List<dynamic> bitacoraAccesoList;
  List<dynamic> noticias;
  DateTime fechaCreacionUsuario;
  DateTime? fechaModificacionUsuario;
  bool enabled;
  bool accountNonLocked;
  List<Authority> authorities;
  bool accountNonExpired;
  bool credentialsNonExpired;

  UsuarioCompletoResponse({
    required this.idUsuario,
    required this.username,
    required this.password,
    required this.estado,
    required this.rol,
    required this.persona,
    required this.bitacoraAccesoList,
    required this.noticias,
    required this.fechaCreacionUsuario,
    this.fechaModificacionUsuario,
    required this.enabled,
    required this.accountNonLocked,
    required this.authorities,
    required this.accountNonExpired,
    required this.credentialsNonExpired,
  });

  factory UsuarioCompletoResponse.fromJson(Map<String, dynamic> json) => UsuarioCompletoResponse(
    idUsuario: json["idUsuario"],
    username: json["username"],
    password: json["password"],
    estado: json["estado"],
    rol: Rol.fromJson(json["rol"]),
    persona: Persona.fromJson(json["persona"]),
    bitacoraAccesoList: List<dynamic>.from(json["bitacoraAccesoList"] ?? []),
    noticias: List<dynamic>.from(json["noticias"] ?? []),
    fechaCreacionUsuario: DateTime.parse(json["fechaCreacionUsuario"]),
    fechaModificacionUsuario: json["fechaModificacionUsuario"] != null
        ? DateTime.tryParse(json["fechaModificacionUsuario"])
        : null,
    enabled: json["enabled"],
    accountNonLocked: json["accountNonLocked"],
    authorities: List<Authority>.from(json["authorities"].map((x) => Authority.fromJson(x))),
    accountNonExpired: json["accountNonExpired"],
    credentialsNonExpired: json["credentialsNonExpired"],
  );

  Map<String, dynamic> toJson() => {
    "idUsuario": idUsuario,
    "username": username,
    "password": password,
    "estado": estado,
    "rol": rol.toJson(),
    "persona": persona.toJson(),
    "bitacoraAccesoList": List<dynamic>.from(bitacoraAccesoList.map((x) => x)),
    "noticias": List<dynamic>.from(noticias.map((x) => x)),
    "fechaCreacionUsuario": fechaCreacionUsuario.toIso8601String(),
    "fechaModificacionUsuario": fechaModificacionUsuario?.toIso8601String(),
    "enabled": enabled,
    "accountNonLocked": accountNonLocked,
    "authorities": List<dynamic>.from(authorities.map((x) => x.toJson())),
    "accountNonExpired": accountNonExpired,
    "credentialsNonExpired": credentialsNonExpired,
  };

  UsuarioCompletoDto toDtoWithUsername(String nuevoUsername) {
    return UsuarioCompletoDto(
      username: nuevoUsername,
      password: password,
      estadoCuenta: estado,
      nombreRol: rol.nombre,
      nombres: persona.nombres,
      apellidos: persona.apellidos,
      tipoDocumento: persona.tipoDocumento,
      numeroDocumento: persona.numeroDocumento,
      telefono: persona.telefono,
      direccion: persona.direccion,
      correoElectronico: persona.correoElectronico,
      fotoPerfil: persona.fotoPerfil ?? "",
      fechaNacimiento: persona.fechaNacimiento,
    );
  }

  UsuarioCompletoDto toDto(
      String nuevoUsername,
      String nuevaPassword,
      String nuevoEstadoCuenta,
      String nuevoNombreRol,
      String nuevosNombres,
      String nuevosApellidos,
      String nuevoTipoDocumento,
      String nuevoNumeroDocumento,
      String nuevoTelefono,
      String nuevaDireccion,
      String nuevoCorreoElectronico,
      String nuevaFotoPerfil,
      DateTime nuevaFechaNacimiento,
      ) {
    return UsuarioCompletoDto(
      username: nuevoUsername,
      password: nuevaPassword,
      estadoCuenta: nuevoEstadoCuenta,
      nombreRol: nuevoNombreRol,
      nombres: nuevosNombres,
      apellidos: nuevosApellidos,
      tipoDocumento: nuevoTipoDocumento,
      numeroDocumento: nuevoNumeroDocumento,
      telefono: nuevoTelefono,
      direccion: nuevaDireccion,
      correoElectronico: nuevoCorreoElectronico,
      fotoPerfil: nuevaFotoPerfil,
      fechaNacimiento: nuevaFechaNacimiento,
    );
  }
}

class Authority {
  String authority;

  Authority({required this.authority});

  factory Authority.fromJson(Map<String, dynamic> json) => Authority(
    authority: json["authority"],
  );

  Map<String, dynamic> toJson() => {
    "authority": authority,
  };
}

class Persona {
  int idPersona;
  String nombres;
  String apellidos;
  String tipoDocumento;
  String numeroDocumento;
  String telefono;
  String direccion;
  String correoElectronico;
  String? fotoPerfil;
  DateTime fechaNacimiento;
  DateTime fechaCreacionPersona;
  DateTime? fechaModificacionPersona;

  Persona({
    required this.idPersona,
    required this.nombres,
    required this.apellidos,
    required this.tipoDocumento,
    required this.numeroDocumento,
    required this.telefono,
    required this.direccion,
    required this.correoElectronico,
    this.fotoPerfil,
    required this.fechaNacimiento,
    required this.fechaCreacionPersona,
    this.fechaModificacionPersona,
  });

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
    idPersona: json["idPersona"],
    nombres: json["nombres"],
    apellidos: json["apellidos"],
    tipoDocumento: json["tipoDocumento"],
    numeroDocumento: json["numeroDocumento"],
    telefono: json["telefono"],
    direccion: json["direccion"],
    correoElectronico: json["correoElectronico"],
    fotoPerfil: json["fotoPerfil"],
    fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
    fechaCreacionPersona: DateTime.parse(json["fechaCreacionPersona"]),
    fechaModificacionPersona: json["fechaModificacionPersona"] != null
        ? DateTime.tryParse(json["fechaModificacionPersona"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "idPersona": idPersona,
    "nombres": nombres,
    "apellidos": apellidos,
    "tipoDocumento": tipoDocumento,
    "numeroDocumento": numeroDocumento,
    "telefono": telefono,
    "direccion": direccion,
    "correoElectronico": correoElectronico,
    "fotoPerfil": fotoPerfil,
    "fechaNacimiento": "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
    "fechaCreacionPersona": fechaCreacionPersona.toIso8601String(),
    "fechaModificacionPersona": fechaModificacionPersona?.toIso8601String(),
  };
}

class Rol {
  int idRol;
  String nombre;
  DateTime fechaCreacionRol;
  DateTime? fechaModificacionRol;

  Rol({
    required this.idRol,
    required this.nombre,
    required this.fechaCreacionRol,
    this.fechaModificacionRol,
  });

  factory Rol.fromJson(Map<String, dynamic> json) => Rol(
    idRol: json["idRol"],
    nombre: json["nombre"],
    fechaCreacionRol: DateTime.parse(json["fechaCreacionRol"]),
    fechaModificacionRol: json["fechaModificacionRol"] != null
        ? DateTime.tryParse(json["fechaModificacionRol"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "idRol": idRol,
    "nombre": nombre,
    "fechaCreacionRol": fechaCreacionRol.toIso8601String(),
    "fechaModificacionRol": fechaModificacionRol?.toIso8601String(),
  };
}