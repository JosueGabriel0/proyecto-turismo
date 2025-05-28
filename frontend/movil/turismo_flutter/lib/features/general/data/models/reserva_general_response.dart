import 'package:turismo_flutter/features/general/data/models/reserva_detalle_general_response.dart';

class ReservaGeneralResponse {
  final int idReserva;
  final DateTime fechaHoraReserva;
  final DateTime fechaHoraInicio;
  final DateTime fechaHoraFin;
  final String estado;
  final int idUsuario;
  final int idEmprendimiento;
  final List<ReservaDetalleGeneralResponse> reservaDetalles;
  final DateTime? fechaCreacionReserva;
  final DateTime? fechaModificacionReserva;

  ReservaGeneralResponse({
    required this.idReserva,
    required this.fechaHoraReserva,
    required this.fechaHoraInicio,
    required this.fechaHoraFin,
    required this.estado,
    required this.idUsuario,
    required this.idEmprendimiento,
    required this.reservaDetalles,
    this.fechaCreacionReserva,
    this.fechaModificacionReserva,
  });

  factory ReservaGeneralResponse.fromJson(Map<String, dynamic> json) {
    return ReservaGeneralResponse(
      idReserva: json['idReserva'],
      fechaHoraReserva: DateTime.parse(json['fechaHoraReserva']),
      fechaHoraInicio: DateTime.parse(json['fechaHoraInicio']),
      fechaHoraFin: DateTime.parse(json['fechaHoraFin']),
      estado: json['estado'],
      idUsuario: json['usuario']?['idUsuario'] ?? 0,
      idEmprendimiento: json['emprendimiento']?['idEmprendimiento'] ?? 0,
      reservaDetalles: (json['reservaDetalles'] as List<dynamic>)
          .map((e) => ReservaDetalleGeneralResponse.fromJson(e))
          .toList(),
      fechaCreacionReserva: json['fechaCreacionReserva'] != null
          ? DateTime.parse(json['fechaCreacionReserva'])
          : null,
      fechaModificacionReserva: json['fechaModificacionReserva'] != null
          ? DateTime.parse(json['fechaModificacionReserva'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idReserva': idReserva,
      'fechaHoraReserva': fechaHoraReserva.toIso8601String(),
      'fechaHoraInicio': fechaHoraInicio.toIso8601String(),
      'fechaHoraFin': fechaHoraFin.toIso8601String(),
      'estado': estado,
      'usuario': {'idUsuario': idUsuario},
      'emprendimiento': {'idEmprendimiento': idEmprendimiento},
      'reservaDetalles': reservaDetalles.map((e) => e.toJson()).toList(),
      'fechaCreacionReserva': fechaCreacionReserva?.toIso8601String(),
      'fechaModificacionReserva': fechaModificacionReserva?.toIso8601String(),
    };
  }
}