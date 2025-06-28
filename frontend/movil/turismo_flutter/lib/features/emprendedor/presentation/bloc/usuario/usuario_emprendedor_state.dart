import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/usuario_emprendedor_response.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/usuario_id_mensaje_emprendedor_dto_response.dart';

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

class BuscarIdInitialEmprendedor extends UsuarioEmprendedorState {}

class BuscarIdLoadingEmprendedor extends UsuarioEmprendedorState {}

class BuscarIdSuccessEmprendedor extends UsuarioEmprendedorState {
  final UsuarioIdMensajeEmprendedorDtoResponse usuario;

  BuscarIdSuccessEmprendedor(this.usuario);
}

class BuscarIdErrorEmprendedor extends UsuarioEmprendedorState {
  final String mensaje;

  BuscarIdErrorEmprendedor(this.mensaje);
}