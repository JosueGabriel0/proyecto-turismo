class PersonaResponse {
  int idPersona;
  String nombres;
  String? apellidos;
  String? tipoDocumento;
  String? numeroDocumento;
  String? telefono;
  String? direccion;
  String? correoElectronico;
  String? fotoPerfil;
  String? fechaNacimiento;
  String? fechaCreacionPersona;
  String? fechaModificacionPersona;

  PersonaResponse({
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

  factory PersonaResponse.fromJson(Map<String, dynamic> json) {
    return PersonaResponse(
      idPersona: json['idPersona'],
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      tipoDocumento: json['tipoDocumento'],
      numeroDocumento: json['numeroDocumento'],
      telefono: json['telefono'],
      direccion: json['direccion'],
      correoElectronico: json['correoElectronico'],
      fotoPerfil: json['fotoPerfil'],
      fechaNacimiento: json['fechaNacimiento'],
      fechaCreacionPersona: json['fechaCreacionPersona'],
      fechaModificacionPersona: json['fechaModificacionPersona'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idPersona': idPersona,
      'nombres': nombres,
      'apellidos': apellidos,
      'tipoDocumento': tipoDocumento,
      'numeroDocumento': numeroDocumento,
      'telefono': telefono,
      'direccion': direccion,
      'correoElectronico': correoElectronico,
      'fotoPerfil': fotoPerfil,
      'fechaNacimiento': fechaNacimiento,
      'fechaCreacionPersona': fechaCreacionPersona,
      'fechaModificacionPersona': fechaModificacionPersona,
    };
  }
}