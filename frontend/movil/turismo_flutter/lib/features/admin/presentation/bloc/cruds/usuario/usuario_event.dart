import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_dto.dart';

abstract class UsuarioEvent extends Equatable {
  const UsuarioEvent();

  @override
  List<Object?> get props => [];
}

class GetAllUsuariosEvent extends UsuarioEvent {}

class GetUsuarioByIdEvent extends UsuarioEvent {
  final int id;
  const GetUsuarioByIdEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class CreateUsuarioEvent extends UsuarioEvent {
  final UsuarioCompletoDto usuario;
  final File? imagen;
  const CreateUsuarioEvent(this.usuario, this.imagen);
  @override
  List<Object?> get props => [usuario, imagen];
}

class UpdateUsuarioEvent extends UsuarioEvent {
  final int id;
  final UsuarioCompletoDto usuario;
  final File? imagen;
  const UpdateUsuarioEvent(this.id, this.usuario, this.imagen);
  @override
  List<Object?> get props => [id, usuario, imagen];
}

class DeleteUsuarioEvent extends UsuarioEvent {
  final int id;
  const DeleteUsuarioEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class GetMyUsuarioEvent extends UsuarioEvent {}

class BuscarUsuarioPorNombreEvent extends UsuarioEvent {
  final String username;

  const BuscarUsuarioPorNombreEvent(this.username);

  @override
  List<Object?> get props => [username];
}

class BuscarIdPorUsernameEvent extends UsuarioEvent {
  final String username;

  BuscarIdPorUsernameEvent(this.username);
}