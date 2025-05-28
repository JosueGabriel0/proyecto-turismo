import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/emprendimiento_emprendedor_dto.dart';

abstract class EmprendimientoEmprendedorEvent extends Equatable {
  const EmprendimientoEmprendedorEvent();

  @override
  List<Object?> get props => [];
}

class GetEmprendimientoByIdUsuarioEmprendedorEvent extends EmprendimientoEmprendedorEvent {
  final int idUsuario;

  const GetEmprendimientoByIdUsuarioEmprendedorEvent(this.idUsuario);

  @override
  List<Object?> get props => [idUsuario];
}

class UpdateEmprendimientoEmprendedorEvent extends EmprendimientoEmprendedorEvent {
  final int idEmprendimiento;
  final EmprendimientoEmprendedorDto dto;
  final File? file;

  const UpdateEmprendimientoEmprendedorEvent(this.idEmprendimiento, this.dto, this.file);

  @override
  List<Object?> get props => [idEmprendimiento, dto, file];
}
