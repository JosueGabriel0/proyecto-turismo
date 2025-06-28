import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/reserva_emprendedor_dto.dart';

abstract class ReservaEmprendedorEvent extends Equatable {
  const ReservaEmprendedorEvent();

  @override
  List<Object?> get props => [];
}

class CrearReservaEvent extends ReservaEmprendedorEvent {
  final ReservaEmprendedorDto reserva;

  const CrearReservaEvent(this.reserva);

  @override
  List<Object?> get props => [reserva];
}

class ActualizarEstadoReservaEvent extends ReservaEmprendedorEvent {
  final int idReserva;
  final String nuevoEstado;

  const ActualizarEstadoReservaEvent(this.idReserva, this.nuevoEstado);

  @override
  List<Object?> get props => [idReserva, nuevoEstado];
}

class ObtenerReservasPorEmprendimientoEvent extends ReservaEmprendedorEvent {
  final int idEmprendimiento;

  const ObtenerReservasPorEmprendimientoEvent(this.idEmprendimiento);

  @override
  List<Object?> get props => [idEmprendimiento];
}

class ObtenerReservaPorIdEvent extends ReservaEmprendedorEvent {
  final int idReserva;

  const ObtenerReservaPorIdEvent(this.idReserva);

  @override
  List<Object?> get props => [idReserva];
}