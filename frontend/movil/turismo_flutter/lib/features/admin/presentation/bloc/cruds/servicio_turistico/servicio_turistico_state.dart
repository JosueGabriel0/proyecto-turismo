import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/lugar_response.dart';
import 'package:turismo_flutter/features/admin/data/models/servicio_turistico_response.dart';

abstract class ServicioTuristicoState extends Equatable{
  const ServicioTuristicoState();

  @override
  List<Object?> get props => [];
}

class ServicioTuristicoInitial extends ServicioTuristicoState{}

class ServicioTuristicoLoading extends ServicioTuristicoState{}

class ServicioTuristicoListLoaded extends ServicioTuristicoState{
  final List<ServicioTuristicoResponse> serviciosTuristicos;
  const ServicioTuristicoListLoaded(this.serviciosTuristicos);

  @override
  List<Object?> get props => [serviciosTuristicos];
}

class ServicioTuristicoLoaded extends ServicioTuristicoState{
  final ServicioTuristicoResponse servicioTuristico;
  const ServicioTuristicoLoaded(this.servicioTuristico);

  @override
  List<Object?> get props => [servicioTuristico];
}

class ServicioTuristicoSuccess extends ServicioTuristicoState{
  final String message;
  const ServicioTuristicoSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ServicioTuristicoError extends ServicioTuristicoState{
  final String message;
  const ServicioTuristicoError(this.message);

  @override
  List<Object?> get props => [message];
}

class ServicioTuristicoSearchLoaded extends ServicioTuristicoState {
  final List<ServicioTuristicoResponse> resultados;

  const ServicioTuristicoSearchLoaded(this.resultados);

  @override
  List<Object?> get props => [resultados];
}