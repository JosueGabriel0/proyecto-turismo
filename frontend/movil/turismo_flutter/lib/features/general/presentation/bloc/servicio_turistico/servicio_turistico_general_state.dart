import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/general/data/models/servicio_turistico_response_general.dart';

abstract class ServicioTuristicoGeneralState extends Equatable {
  const ServicioTuristicoGeneralState();

  @override
  List<Object?> get props => [];
}

class ServicioTuristicoGeneralInitial extends ServicioTuristicoGeneralState {}

class ServicioTuristicoGeneralLoading extends ServicioTuristicoGeneralState {}

class ServicioTuristicoGeneralLoaded extends ServicioTuristicoGeneralState {
  final List<ServicioTuristicoResponseGeneral> servicios;

  const ServicioTuristicoGeneralLoaded(this.servicios);

  @override
  List<Object?> get props => [servicios];
}

class ServicioTuristicoGeneralError extends ServicioTuristicoGeneralState {
  final String message;

  const ServicioTuristicoGeneralError(this.message);

  @override
  List<Object?> get props => [message];
}
