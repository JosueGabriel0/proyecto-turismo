import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/usuario/data/models/reserva_response.dart';
import 'package:turismo_flutter/features/usuario/data/models/reserva_user_response.dart';

abstract class ReservaState extends Equatable {
  const ReservaState();

  @override
  List<Object?> get props => [];
}

class ReservaInitial extends ReservaState {}

class ReservaLoading extends ReservaState {}

class ReservaLoaded extends ReservaState {
  final ReservaUserResponse reserva;
  const ReservaLoaded(this.reserva);

  @override
  List<Object?> get props => [reserva];
}

class ReservaListLoaded extends ReservaState {
  final List<ReservaUserResponse> reservas;

  const ReservaListLoaded(this.reservas);

  @override
  List<Object?> get props => [reservas];
}

class ReservaCreada extends ReservaState {
  final ReservaResponse reserva;

  const ReservaCreada(this.reserva);

  @override
  List<Object?> get props => [reserva];
}

class TelefonoObtenido extends ReservaState {
  final String telefono;

  const TelefonoObtenido(this.telefono);

  @override
  List<Object?> get props => [telefono];
}

class ReservaError extends ReservaState {
  final String message;

  const ReservaError(this.message);

  @override
  List<Object?> get props => [message];
}