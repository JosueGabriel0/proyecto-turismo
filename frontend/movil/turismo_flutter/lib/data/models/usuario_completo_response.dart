import 'dart:convert';

List<UsuarioCompletoResponse> usuarioCompletoResponseFromJson(String str) => List<UsuarioCompletoResponse>.from(json.decode(str).map((x) => UsuarioCompletoResponse.fromJson(x)));

UsuarioCompletoResponse usuarioFromJson(String str) => UsuarioCompletoResponse.fromJson(json.decode(str));
String usuarioCompletoResponseToJson(List<UsuarioCompletoResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
  dynamic fechaModificacionUsuario;
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
    required this.fechaModificacionUsuario,
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
    bitacoraAccesoList: List<dynamic>.from(json["bitacoraAccesoList"].map((x) => x)),
    noticias: List<dynamic>.from(json["noticias"].map((x) => x)),
    fechaCreacionUsuario: DateTime.parse(json["fechaCreacionUsuario"]),
    fechaModificacionUsuario: json["fechaModificacionUsuario"],
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
    "fechaModificacionUsuario": fechaModificacionUsuario,
    "enabled": enabled,
    "accountNonLocked": accountNonLocked,
    "authorities": List<dynamic>.from(authorities.map((x) => x.toJson())),
    "accountNonExpired": accountNonExpired,
    "credentialsNonExpired": credentialsNonExpired,
  };
}

class Authority {
  String authority;

  Authority({
    required this.authority,
  });

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
  dynamic fotoPerfil;
  DateTime fechaNacimiento;
  DateTime fechaCreacionPersona;
  dynamic fechaModificacionPersona;

  Persona({
    required this.idPersona,
    required this.nombres,
    required this.apellidos,
    required this.tipoDocumento,
    required this.numeroDocumento,
    required this.telefono,
    required this.direccion,
    required this.correoElectronico,
    required this.fotoPerfil,
    required this.fechaNacimiento,
    required this.fechaCreacionPersona,
    required this.fechaModificacionPersona,
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
    fechaModificacionPersona: json["fechaModificacionPersona"],
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
    "fechaModificacionPersona": fechaModificacionPersona,
  };
}

class Rol {
  int idRol;
  String nombre;
  DateTime fechaCreacionRol;
  dynamic fechaModificacionRol;

  Rol({
    required this.idRol,
    required this.nombre,
    required this.fechaCreacionRol,
    required this.fechaModificacionRol,
  });

  factory Rol.fromJson(Map<String, dynamic> json) => Rol(
    idRol: json["idRol"],
    nombre: json["nombre"],
    fechaCreacionRol: DateTime.parse(json["fechaCreacionRol"]),
    fechaModificacionRol: json["fechaModificacionRol"],
  );

  Map<String, dynamic> toJson() => {
    "idRol": idRol,
    "nombre": nombre,
    "fechaCreacionRol": fechaCreacionRol.toIso8601String(),
    "fechaModificacionRol": fechaModificacionRol,
  };
}