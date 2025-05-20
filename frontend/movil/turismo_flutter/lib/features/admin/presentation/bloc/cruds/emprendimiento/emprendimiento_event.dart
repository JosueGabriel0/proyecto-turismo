import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/emprendimiento_response.dart';

class EmprendimientoEvent extends Equatable {
  const EmprendimientoEvent();

  @override
  List<Object?> get props => [];
}

class GetEmprendimientosEvent extends EmprendimientoEvent {
  const GetEmprendimientosEvent();

  @override
  List<Object?> get props => [];
}

class GetEmprendimientoByIdEvent extends EmprendimientoEvent {
  final int idEmprendimiento;

  const GetEmprendimientoByIdEvent(this.idEmprendimiento);

  @override
  List<Object?> get props => [idEmprendimiento];
}

class PostEmprendimientoEvent extends EmprendimientoEvent {
  final EmprendimientoDto emprendimientoDto;
  final File? file;

  const PostEmprendimientoEvent(this.emprendimientoDto, this.file);

  @override
  List<Object?> get props => [emprendimientoDto, file];
}

class PutEmprendimientoEvent extends EmprendimientoEvent {
  final int idEmprendimiento;
  final EmprendimientoDto emprendimientoDto;
  final File? file;

  const PutEmprendimientoEvent(this.idEmprendimiento, this.emprendimientoDto, this.file);

  @override
  List<Object?> get props => [idEmprendimiento, emprendimientoDto, file];
}

class DeleteEmprendimientoEvent extends EmprendimientoEvent {
  final int idEmprendimiento;

  const DeleteEmprendimientoEvent(this.idEmprendimiento);

  @override
  List<Object?> get props => [idEmprendimiento];
}

class BuscarEmprendimientosPorNombreEvent extends EmprendimientoEvent {
  final String nombre;

  const BuscarEmprendimientosPorNombreEvent(this.nombre);

  @override
  List<Object?> get props => [nombre];
}

