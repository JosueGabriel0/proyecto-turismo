import 'package:turismo_flutter/features/general/data/models/reserva_detalle_general_response.dart';
import 'package:turismo_flutter/features/usuario/data/models/reserva_detalle_user_response.dart';

class ReservaUserResponse {
  final int idReserva;
  final DateTime fechaHoraReserva;
  final DateTime fechaHoraInicio;
  final DateTime fechaHoraFin;
  final String estado;
  final int idUsuario;
  final int idEmprendimiento;
  final double totalGeneral;
  final List<ReservaDetalleUserResponse> reservaDetalles;
  final DateTime? fechaCreacionReserva;
  final DateTime? fechaModificacionReserva;

  ReservaUserResponse({
    required this.idReserva,
    required this.fechaHoraReserva,
    required this.fechaHoraInicio,
    required this.fechaHoraFin,
    required this.estado,
    required this.idUsuario,
    required this.idEmprendimiento,
    required this.totalGeneral,
    required this.reservaDetalles,
    this.fechaCreacionReserva,
    this.fechaModificacionReserva,
  });

  factory ReservaUserResponse.fromJson(Map<String, dynamic> json) {
    return ReservaUserResponse(
      idReserva: json['idReserva'],
      fechaHoraReserva: DateTime.parse(json['fechaHoraReserva']),
      fechaHoraInicio: DateTime.parse(json['fechaHoraInicio']),
      fechaHoraFin: DateTime.parse(json['fechaHoraFin']),
      estado: json['estado'],
      idUsuario: json['usuario']?['idUsuario'] ?? 0,
      idEmprendimiento: json['emprendimiento']?['idEmprendimiento'] ?? 0,
      totalGeneral: (json['totalGeneral'] ?? 0).toDouble(),
      reservaDetalles: (json['reservaDetalles'] as List<dynamic>)
          .map((e) => ReservaDetalleUserResponse.fromJson(e))
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
      'totalGeneral': totalGeneral,
      'reservaDetalles': reservaDetalles.map((e) => e.toJson()).toList(),
      'fechaCreacionReserva': fechaCreacionReserva?.toIso8601String(),
      'fechaModificacionReserva': fechaModificacionReserva?.toIso8601String(),
    };
  }
}