import 'dart:convert';

UsuarioCompletoDto usuarioCompletoDtoFromJson(String str) =>
    UsuarioCompletoDto.fromJson(json.decode(str));

String usuarioCompletoDtoToJson(UsuarioCompletoDto data) =>
    json.encode(data.toJson());

class UsuarioCompletoDto {
  String username;
  String password;
  String estadoCuenta;
  String nombreRol;
  String? nombreEmprendimiento;
  String nombres;
  String apellidos;
  String tipoDocumento;
  String numeroDocumento;
  String telefono;
  String direccion;
  String correoElectronico;
  String fechaNacimiento;

  UsuarioCompletoDto({
    required this.username,
    required this.password,
    required this.estadoCuenta,
    required this.nombreRol,
    required this.nombreEmprendimiento,
    required this.nombres,
    required this.apellidos,
    required this.tipoDocumento,
    required this.numeroDocumento,
    required this.telefono,
    required this.direccion,
    required this.correoElectronico,
    required this.fechaNacimiento,
  });

  factory UsuarioCompletoDto.fromJson(Map<String, dynamic> json) =>
      UsuarioCompletoDto(
        username: json["username"],
        password: json["password"],
        estadoCuenta: json["estadoCuenta"],
        nombreRol: json["nombreRol"],
        nombreEmprendimiento: json["nombreEmprendimiento"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        tipoDocumento: json["tipoDocumento"],
        numeroDocumento: json["numeroDocumento"],
        telefono: json["telefono"],
        direccion: json["direccion"],
        correoElectronico: json["correoElectronico"],
        fechaNacimiento: json["fechaNacimiento"],
      );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "estadoCuenta": estadoCuenta,
    "nombreRol": nombreRol,
    "nombreEmprendimiento": nombreEmprendimiento,
    "nombres": nombres,
    "apellidos": apellidos,
    "tipoDocumento": tipoDocumento,
    "numeroDocumento": numeroDocumento,
    "telefono": telefono,
    "direccion": direccion,
    "correoElectronico": correoElectronico,
    "fechaNacimiento": fechaNacimiento,
  };

  @override
  String toString() {
    return 'UsuarioCompletoDto('
        'username: $username, '
        'password: $password, '
        'estadoCuenta: $estadoCuenta, '
        'nombreRol: $nombreRol, '
        'nombreEmprendimiento: $nombreEmprendimiento, '
        'nombres: $nombres, '
        'apellidos: $apellidos, '
        'tipoDocumento: $tipoDocumento, '
        'numeroDocumento: $numeroDocumento, '
        'telefono: $telefono, '
        'direccion: $direccion, '
        'correoElectronico: $correoElectronico, '
        'fechaNacimiento: $fechaNacimiento'
        ')';
  }
}