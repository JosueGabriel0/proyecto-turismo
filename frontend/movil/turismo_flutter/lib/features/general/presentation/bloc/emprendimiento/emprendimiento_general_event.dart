import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';

class EmprendimientoGeneralEvent extends Equatable {
  const EmprendimientoGeneralEvent();

  @override
  List<Object?> get props => [];
}

class GetEmprendimientosGeneralEvent extends EmprendimientoGeneralEvent {
  const GetEmprendimientosGeneralEvent();

  @override
  List<Object?> get props => [];
}

class GetEmprendimientoByIdGeneralEvent extends EmprendimientoGeneralEvent {
  final int idEmprendimiento;

  const GetEmprendimientoByIdGeneralEvent(this.idEmprendimiento);

  @override
  List<Object?> get props => [idEmprendimiento];
}

class BuscarEmprendimientosPorNombreGeneralEvent extends EmprendimientoGeneralEvent {
  final String nombre;

  const BuscarEmprendimientosPorNombreGeneralEvent(this.nombre);

  @override
  List<Object?> get props => [nombre];
}