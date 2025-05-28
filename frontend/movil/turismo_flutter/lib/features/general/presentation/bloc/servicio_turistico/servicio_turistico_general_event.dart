import 'package:equatable/equatable.dart';

abstract class ServicioTuristicoGeneralEvent extends Equatable {
  const ServicioTuristicoGeneralEvent();

  @override
  List<Object?> get props => [];
}

class GetServiciosPorEmprendimientoEvent extends ServicioTuristicoGeneralEvent {
  final int idEmprendimiento;

  const GetServiciosPorEmprendimientoEvent(this.idEmprendimiento);

  @override
  List<Object?> get props => [idEmprendimiento];
}