import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_dto.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_user_dto.dart';

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
  final int id;
  final UsuarioUserDto usuario;
  final File? imagen;
  const PutUsuarioUserEvent(this.id, this.usuario, this.imagen);
  @override
  List<Object?> get props => [id, usuario, imagen];
}

class GetMyUsuarioUserEvent extends UsuarioUserEvent {}