import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_dto.dart';

abstract class PerfilAdminEvent extends Equatable {
  const PerfilAdminEvent();
  @override
  List<Object?> get props => [];
}

class LoadPerfilAdminEvent extends PerfilAdminEvent {}

class UpdatePerfilAdminEvent extends PerfilAdminEvent {
  final UsuarioCompletoDto usuario;
  final File? imagen;

  const UpdatePerfilAdminEvent(this.usuario, this.imagen);

  @override
  List<Object?> get props => [usuario, imagen];
}