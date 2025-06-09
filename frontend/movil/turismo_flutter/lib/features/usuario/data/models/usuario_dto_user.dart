class UsuarioDtoUser {
  String username;
  String? password;
  String nombres;
  String apellidos;
  String tipoDocumento;
  String numeroDocumento;
  String telefono;
  String direccion;
  String correoElectronico;
  String fechaNacimiento;

  UsuarioDtoUser({
    required this.username,
    required this.password,
    required this.nombres,
    required this.apellidos,
    required this.tipoDocumento,
    required this.numeroDocumento,
    required this.telefono,
    required this.direccion,
    required this.correoElectronico,
    required this.fechaNacimiento,
  });

  factory UsuarioDtoUser.fromJson(Map<String, dynamic> json) {
    return UsuarioDtoUser(
      username: json['username'],
      password: json['password'],
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      tipoDocumento: json['tipoDocumento'],
      numeroDocumento: json['numeroDocumento'],
      telefono: json['telefono'],
      direccion: json['direccion'],
      correoElectronico: json['correoElectronico'],
      fechaNacimiento: json['fechaNacimiento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'nombres': nombres,
      'apellidos': apellidos,
      'tipoDocumento': tipoDocumento,
      'numeroDocumento': numeroDocumento,
      'telefono': telefono,
      'direccion': direccion,
      'correoElectronico': correoElectronico,
      'fechaNacimiento': fechaNacimiento, // formato yyyy-MM-dd
    };
  }
}