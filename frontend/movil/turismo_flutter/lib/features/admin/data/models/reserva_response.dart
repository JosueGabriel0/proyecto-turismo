import 'package:turismo_flutter/features/admin/data/models/reserva_detalle_response.dart';

class ReservaResponse {
  int idReserva;
  String fechaHoraReserva;
  String fechaHoraInicio;
  String fechaHoraFin;
  String estado;
  int usuarioId; // solo el ID, puedes expandir a un modelo si es necesario
  int emprendimientoId; // igual que usuarioId
  List<ReservaDetalleResponse>? reservaDetalles; // puede ser null
  String? fechaCreacionReserva;
  String? fechaModificacionReserva;

  ReservaResponse({
    required this.idReserva,
    required this.fechaHoraReserva,
    required this.fechaHoraInicio,
    required this.fechaHoraFin,
    required this.estado,
    required this.usuarioId,
    required this.emprendimientoId,
    this.reservaDetalles,
    this.fechaCreacionReserva,
    this.fechaModificacionReserva,
  });

  factory ReservaResponse.fromJson(Map<String, dynamic> json) {
    return ReservaResponse(
      idReserva: json['idReserva'],
      fechaHoraReserva: json['fechaHoraReserva'],
      fechaHoraInicio: json['fechaHoraInicio'],
      fechaHoraFin: json['fechaHoraFin'],
      estado: json['estado'],
      usuarioId: json['usuario']['idUsuario'], // o simplemente json['usuario'] si solo te llega el ID
      emprendimientoId: json['emprendimiento']['idEmprendimiento'],
      reservaDetalles: json['reservaDetalles'] != null
          ? List<ReservaDetalleResponse>.from(json['reservaDetalles'])
          : null,
      fechaCreacionReserva: json['fechaCreacionReserva'],
      fechaModificacionReserva: json['fechaModificacionReserva'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idReserva': idReserva,
      'fechaHoraReserva': fechaHoraReserva,
      'fechaHoraInicio': fechaHoraInicio,
      'fechaHoraFin': fechaHoraFin,
      'estado': estado,
      'usuario': {'idUsuario': usuarioId},
      'emprendimiento': {'idEmprendimiento': emprendimientoId},
      'reservaDetalles': reservaDetalles,
      'fechaCreacionReserva': fechaCreacionReserva,
      'fechaModificacionReserva': fechaModificacionReserva,
    };
  }
}