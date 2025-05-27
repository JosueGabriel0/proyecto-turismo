class ReservaResponse {
  final int idReserva;
  final String estado;
  final UsuarioReserva usuario;
  final int idEmprendimiento;
  final DateTime fechaHoraInicio;
  final DateTime fechaHoraFin;
  final DateTime fechaHoraReserva;

  ReservaResponse({
    required this.idReserva,
    required this.estado,
    required this.usuario,
    required this.idEmprendimiento,
    required this.fechaHoraInicio,
    required this.fechaHoraFin,
    required this.fechaHoraReserva,
  });

  factory ReservaResponse.fromJson(Map<String, dynamic> json) {
    return ReservaResponse(
      idReserva: json['idReserva'],
      estado: json['estado'],
      usuario: UsuarioReserva.fromJson(json['usuario']),
      idEmprendimiento: json['idEmprendimiento'],
      fechaHoraInicio: DateTime.parse(json['fechaHoraInicio']),
      fechaHoraFin: DateTime.parse(json['fechaHoraFin']),
      fechaHoraReserva: DateTime.parse(json['fechaHoraReserva']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idReserva': idReserva,
      'estado': estado,
      'usuario': usuario.toJson(),
      'idEmprendimiento': idEmprendimiento,
      'fechaHoraInicio': fechaHoraInicio.toIso8601String(),
      'fechaHoraFin': fechaHoraFin.toIso8601String(),
      'fechaHoraReserva': fechaHoraReserva.toIso8601String(),
    };
  }
}

class UsuarioReserva {
  final int idUsuario;
  final String username;
  final String nombrePersona;
  final String rolNombre;

  UsuarioReserva({
    required this.idUsuario,
    required this.username,
    required this.nombrePersona,
    required this.rolNombre,
  });

  factory UsuarioReserva.fromJson(Map<String, dynamic> json) {
    return UsuarioReserva(
      idUsuario: json['idUsuario'],
      username: json['username'],
      nombrePersona: json['nombrePersona'],
      rolNombre: json['rolNombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUsuario': idUsuario,
      'username': username,
      'nombrePersona': nombrePersona,
      'rolNombre': rolNombre,
    };
  }
}