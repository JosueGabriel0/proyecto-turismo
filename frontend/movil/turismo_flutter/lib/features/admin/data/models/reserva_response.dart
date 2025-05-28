import 'reserva_detalle_response.dart';

class ReservaResponse {
  final int idReserva;
  final DateTime fechaHoraReserva;
  final DateTime fechaHoraInicio;
  final DateTime fechaHoraFin;
  final String estado;
  final List<ReservaDetalleResponse> reservaDetalles;
  final DateTime? fechaCreacionReserva;
  final DateTime? fechaModificacionReserva;

  ReservaResponse({
    required this.idReserva,
    required this.fechaHoraReserva,
    required this.fechaHoraInicio,
    required this.fechaHoraFin,
    required this.estado,
    required this.reservaDetalles,
    this.fechaCreacionReserva,
    this.fechaModificacionReserva,
  });

  factory ReservaResponse.fromJson(Map<String, dynamic> json) {
    return ReservaResponse(
      idReserva: json['idReserva'],
      fechaHoraReserva: DateTime.parse(json['fechaHoraReserva']),
      fechaHoraInicio: DateTime.parse(json['fechaHoraInicio']),
      fechaHoraFin: DateTime.parse(json['fechaHoraFin']),
      estado: json['estado'],
      reservaDetalles: (json['reservaDetalles'] as List<dynamic>)
          .map((e) => ReservaDetalleResponse.fromJson(e))
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
      'reservaDetalles': reservaDetalles.map((e) => e.toJson()).toList(),
      'fechaCreacionReserva': fechaCreacionReserva?.toIso8601String(),
      'fechaModificacionReserva': fechaModificacionReserva?.toIso8601String(),
    };
  }
}