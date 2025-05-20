import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/rol_dto.dart';

abstract class RolEvent extends Equatable {
  const RolEvent();
  @override
  List<Object?> get props => [];
}

class GetRolesEvent extends RolEvent {}

class GetRolByIdEvent extends RolEvent {
  final int idRol;

  GetRolByIdEvent({required this.idRol});

  @override
  List<Object?> get props => [idRol];
}

class CreateRolEvent extends RolEvent {
  final RolDto rolDto;

  CreateRolEvent({required this.rolDto});

  @override
  List<Object?> get props => [rolDto];
}

class UpdateRolEvent extends RolEvent {
  final int idRol;
  final RolDto rolDto;

  UpdateRolEvent({required this.idRol, required this.rolDto});

  @override
  List<Object?> get props => [idRol, rolDto];
}

class DeleteRolEvent extends RolEvent {
  final int idRol;

  DeleteRolEvent({required this.idRol});

  @override
  List<Object?> get props => [idRol];
}

class BuscarRolPorNombreEvent extends RolEvent {
  final String nombre;

  const BuscarRolPorNombreEvent(this.nombre);

  @override
  List<Object?> get props => [nombre];
}