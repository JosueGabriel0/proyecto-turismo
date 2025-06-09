import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/usuario_emprendedor_response.dart';

abstract class UsuarioEmprendedorState extends Equatable {
  const UsuarioEmprendedorState();

  @override
  List<Object?> get props => [];
}

class UsuarioEmprendedorInitial extends UsuarioEmprendedorState {}

class UsuarioEmprendedorLoading extends UsuarioEmprendedorState {}

class UsuarioEmprendedorProfileLoaded extends UsuarioEmprendedorState {
  final UsuarioEmprendedorResponse usuario;
  const UsuarioEmprendedorProfileLoaded(this.usuario);

  @override
  List<Object?> get props => [usuario];
}

class UsuarioEmprendedorSuccess extends UsuarioEmprendedorState {
  final String message;
  const UsuarioEmprendedorSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class UsuarioEmprendedorError extends UsuarioEmprendedorState {
  final String message;
  const UsuarioEmprendedorError(this.message);
  @override
  List<Object?> get props => [message];
}