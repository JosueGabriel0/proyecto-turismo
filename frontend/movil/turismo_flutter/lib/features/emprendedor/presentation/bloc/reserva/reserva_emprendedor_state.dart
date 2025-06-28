import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/reserva_emprendedor_completo_response.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/reserva_emprendedor_response.dart';

abstract class ReservaEmprendedorState extends Equatable {
  const ReservaEmprendedorState();

  @override
  List<Object?> get props => [];
}

class ReservaInitial extends ReservaEmprendedorState {}

class ReservaLoading extends ReservaEmprendedorState {}

class ReservaCreada extends ReservaEmprendedorState {
  final ReservaEmprendedorResponse reserva;

  const ReservaCreada(this.reserva);

  @override
  List<Object?> get props => [reserva];
}

class ReservaActualizada extends ReservaEmprendedorState {
  final ReservaEmprendedorResponse reserva;

  const ReservaActualizada(this.reserva);

  @override
  List<Object?> get props => [reserva];
}

class ReservasCargadas extends ReservaEmprendedorState {
  final List<ReservaEmprendedorCompletoResponse> reservas;

  const ReservasCargadas(this.reservas);

  @override
  List<Object?> get props => [reservas];
}

class ReservaCargada extends ReservaEmprendedorState {
  final ReservaEmprendedorCompletoResponse reserva;

  const ReservaCargada(this.reserva);

  @override
  List<Object?> get props => [reserva];
}

class ReservaError extends ReservaEmprendedorState {
  final String mensaje;

  const ReservaError(this.mensaje);

  @override
  List<Object?> get props => [mensaje];
}