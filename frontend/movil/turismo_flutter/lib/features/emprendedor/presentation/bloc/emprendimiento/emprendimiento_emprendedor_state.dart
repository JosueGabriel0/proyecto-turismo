import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/emprendimiento_emprendedor_response.dart';

abstract class EmprendimientoEmprendedorState extends Equatable {
  const EmprendimientoEmprendedorState();

  @override
  List<Object?> get props => [];
}

class EmprendimientoEmprendedorInitial extends EmprendimientoEmprendedorState {}

class EmprendimientoEmprendedorLoading extends EmprendimientoEmprendedorState {}

class EmprendimientoEmprendedorLoaded extends EmprendimientoEmprendedorState {
  final EmprendimientoEmprendedorResponse response;

  const EmprendimientoEmprendedorLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class EmprendimientoEmprendedorUpdating extends EmprendimientoEmprendedorState {}

class EmprendimientoEmprendedorUpdated extends EmprendimientoEmprendedorState {
  final EmprendimientoEmprendedorResponse response;

  const EmprendimientoEmprendedorUpdated(this.response);

  @override
  List<Object?> get props => [response];
}

class EmprendimientoEmprendedorError extends EmprendimientoEmprendedorState {
  final String message;

  const EmprendimientoEmprendedorError(this.message);

  @override
  List<Object?> get props => [message];
}
