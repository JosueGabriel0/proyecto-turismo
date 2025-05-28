import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/servicio_turistico_emprendedor_response.dart';

abstract class ServicioTuristicoEmprendedorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServicioInitialEmprendedor extends ServicioTuristicoEmprendedorState {}

class ServicioLoadingEmprendedor extends ServicioTuristicoEmprendedorState {}

class ServicioListLoadedEmprendedor extends ServicioTuristicoEmprendedorState {
  final List<ServicioTuristicoEmprendedorResponse> servicios;
  ServicioListLoadedEmprendedor(this.servicios);

  @override
  List<Object?> get props => [servicios];
}

class ServicioLoadedEmprendedor extends ServicioTuristicoEmprendedorState {
  final ServicioTuristicoEmprendedorResponse servicio;
  ServicioLoadedEmprendedor(this.servicio);

  @override
  List<Object?> get props => [servicio];
}

class ServicioSuccessEmprendedor extends ServicioTuristicoEmprendedorState {}

class ServicioErrorEmprendedor extends ServicioTuristicoEmprendedorState {
  final String message;
  ServicioErrorEmprendedor(this.message);

  @override
  List<Object?> get props => [message];
}