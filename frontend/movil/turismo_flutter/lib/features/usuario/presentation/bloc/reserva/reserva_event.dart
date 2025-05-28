import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/usuario/data/models/reserva_dto.dart';

abstract class ReservaEvent extends Equatable {
  const ReservaEvent();

  @override
  List<Object?> get props => [];
}

class CrearReservaEvent extends ReservaEvent {
  final ReservaDto reserva;

  const CrearReservaEvent(this.reserva);

  @override
  List<Object?> get props => [reserva];
}

class ObtenerTelefonoEvent extends ReservaEvent {
  final int idEmprendimiento;

  const ObtenerTelefonoEvent(this.idEmprendimiento);

  @override
  List<Object?> get props => [idEmprendimiento];
}

class ObtenerReservasPorIdUsuarioEvent extends ReservaEvent {
  final int id;

  const ObtenerReservasPorIdUsuarioEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ObtenerReservaPorIdEvent extends ReservaEvent {
  final int idReserva;

  const ObtenerReservaPorIdEvent(this.idReserva);

  @override
  List<Object?> get props => [idReserva];
}