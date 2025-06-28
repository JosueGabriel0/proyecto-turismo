import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_dto_user.dart';

abstract class UsuarioUserEvent extends Equatable {
  const UsuarioUserEvent();

  @override
  List<Object?> get props => [];
}

class GetUsuarioByIdUserEvent extends UsuarioUserEvent {
  final int id;
  const GetUsuarioByIdUserEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class PutUsuarioUserEvent extends UsuarioUserEvent {
  final UsuarioDtoUser usuario;
  final File? imagen;
  const PutUsuarioUserEvent(this.usuario, this.imagen);
  @override
  List<Object?> get props => [usuario, imagen];
}

class GetMyUsuarioUserEvent extends UsuarioUserEvent {}

class BuscarIdPorUsernameUserEvent extends UsuarioUserEvent {
  final String username;

  BuscarIdPorUsernameUserEvent(this.username);
}