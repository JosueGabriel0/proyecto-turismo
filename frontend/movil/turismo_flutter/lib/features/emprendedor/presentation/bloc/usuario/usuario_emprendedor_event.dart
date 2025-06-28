import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/usuario_emprendedor_dto.dart';

abstract class UsuarioEmprendedorEvent extends Equatable {
  const UsuarioEmprendedorEvent();

  @override
  List<Object?> get props => [];
}

class GetUsuarioByIdEmprendedorEvent extends UsuarioEmprendedorEvent {
  final int id;
  const GetUsuarioByIdEmprendedorEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class PutUsuarioEmprendedorEvent extends UsuarioEmprendedorEvent {
  final UsuarioEmprendedorDto usuario;
  final File? imagen;
  const PutUsuarioEmprendedorEvent(this.usuario, this.imagen);
  @override
  List<Object?> get props => [usuario, imagen];
}

class GetMyUsuarioEmprendedorEvent extends UsuarioEmprendedorEvent {}

class BuscarIdPorUsernameEmprendedorEvent extends UsuarioEmprendedorEvent {
  final String username;

  BuscarIdPorUsernameEmprendedorEvent(this.username);
}