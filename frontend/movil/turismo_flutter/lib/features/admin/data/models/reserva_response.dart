

import 'package:turismo_flutter/features/admin/data/models/usuario_completo_response.dart';

class Reserva {
  int idReserva;
  DateTime fechaHoraReserva;
  DateTime fechaHoraInicio;
  DateTime fechaHoraFin;
  String estado;
  UsuarioCompletoResponse usuario;
  String emprendimiento;
  DateTime fechaCreacionReserva;
  DateTime fechaModificacionReserva;

  Reserva({
    required this.idReserva,
    required this.fechaHoraReserva,
    required this.fechaHoraInicio,
    required this.fechaHoraFin,
    required this.estado,
    required this.usuario,
    required this.emprendimiento,
    required this.fechaCreacionReserva,
    required this.fechaModificacionReserva,
  });

  factory Reserva.fromJson(Map<String, dynamic> json) {
    return Reserva(
      idReserva: json['idReserva'],
      fechaHoraReserva: DateTime.parse(json['fechaHoraReserva']),
      fechaHoraInicio: DateTime.parse(json['fechaHoraInicio']),
      fechaHoraFin: DateTime.parse(json['fechaHoraFin']),
      estado: json['estado'],
      usuario: UsuarioCompletoResponse.fromJson(json['usuario']),
      emprendimiento: json['emprendimiento'],
      fechaCreacionReserva: DateTime.parse(json['fechaCreacionReserva']),
      fechaModificacionReserva: DateTime.parse(json['fechaModificacionReserva']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idReserva': idReserva,
      'fechaHoraReserva': fechaHoraReserva.toIso8601String(),
      'fechaHoraInicio': fechaHoraInicio.toIso8601String(),
      'fechaHoraFin': fechaHoraFin.toIso8601String(),
      'estado': estado,
      'usuario': usuario.toJson(),
      'emprendimiento': emprendimiento,
      'fechaCreacionReserva': fechaCreacionReserva.toIso8601String(),
      'fechaModificacionReserva': fechaModificacionReserva.toIso8601String(),
    };
  }
}