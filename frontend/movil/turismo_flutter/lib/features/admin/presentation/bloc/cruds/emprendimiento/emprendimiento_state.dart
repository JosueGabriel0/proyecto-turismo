import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';

class EmprendimientoState extends Equatable {
  const EmprendimientoState();

  @override
  List<Object?> get props => [];
}

class EmprendimientoInitial extends EmprendimientoState {}
class EmprendimientoLoading extends EmprendimientoState {}

class EmprendimientoListLoaded extends EmprendimientoState {
  final List<EmprendimientoResponse> emprendimientos;
  const EmprendimientoListLoaded(this.emprendimientos);

  @override
  List<Object?> get props => [emprendimientos];
}

class EmprendimientoLoaded extends EmprendimientoState {
  final EmprendimientoResponse emprendimiento;
  const EmprendimientoLoaded(this.emprendimiento);

  @override
  List<Object?> get props => [emprendimiento];
}

class EmprendimientoSuccess extends EmprendimientoState {
  final String message;
  const EmprendimientoSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class EmprendimientoError extends EmprendimientoState {
  final String message;
  const EmprendimientoError(this.message);

  @override
  List<Object?> get props => [message];
}

class EmprendimientoSearchLoaded extends EmprendimientoState {
  final List<EmprendimientoResponse> resultados;

  const EmprendimientoSearchLoaded(this.resultados);

  @override
  List<Object?> get props => [resultados];
}
