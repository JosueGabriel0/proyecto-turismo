import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';
import 'package:turismo_flutter/features/general/data/models/emprendimiento_general_response.dart';

class EmprendimientoGeneralState extends Equatable {
  const EmprendimientoGeneralState();

  @override
  List<Object?> get props => [];
}

class EmprendimientoInitialGeneral extends EmprendimientoGeneralState {}
class EmprendimientoLoadingGeneral extends EmprendimientoGeneralState {}

class EmprendimientoListLoadedGeneral extends EmprendimientoGeneralState {
  final List<EmprendimientoGeneralResponse> emprendimientos;
  const EmprendimientoListLoadedGeneral(this.emprendimientos);

  @override
  List<Object?> get props => [emprendimientos];
}

class EmprendimientoLoadedGeneral extends EmprendimientoGeneralState {
  final EmprendimientoGeneralResponse emprendimiento;
  const EmprendimientoLoadedGeneral(this.emprendimiento);

  @override
  List<Object?> get props => [emprendimiento];
}

class EmprendimientoSuccessGeneral extends EmprendimientoGeneralState {
  final String message;
  const EmprendimientoSuccessGeneral(this.message);

  @override
  List<Object?> get props => [message];
}

class EmprendimientoErrorGeneral extends EmprendimientoGeneralState {
  final String message;
  const EmprendimientoErrorGeneral(this.message);

  @override
  List<Object?> get props => [message];
}

class EmprendimientoSearchLoadedGeneral extends EmprendimientoGeneralState {
  final List<EmprendimientoGeneralResponse> resultados;

  const EmprendimientoSearchLoadedGeneral(this.resultados);

  @override
  List<Object?> get props => [resultados];
}
