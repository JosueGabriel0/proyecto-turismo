import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_id_mensaje_dto_response.dart';

abstract class UsuarioState extends Equatable {
  const UsuarioState();

  @override
  List<Object?> get props => [];
}

class UsuarioInitial extends UsuarioState {}

class UsuarioLoading extends UsuarioState {}

class UsuarioListLoaded extends UsuarioState {
  final List<UsuarioCompletoResponse> usuarios;
  const UsuarioListLoaded(this.usuarios);
  @override
  List<Object?> get props => [usuarios];
}

class UsuarioProfileLoaded extends UsuarioState {
  final UsuarioCompletoResponse usuario;
  const UsuarioProfileLoaded(this.usuario);

  @override
  List<Object?> get props => [usuario];
}

class UsuarioSuccess extends UsuarioState {
  final String message;
  const UsuarioSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class UsuarioError extends UsuarioState {
  final String message;
  const UsuarioError(this.message);
  @override
  List<Object?> get props => [message];
}

class UsuarioSearchLoaded extends UsuarioState {
  final List<UsuarioCompletoResponse> resultados;

  const UsuarioSearchLoaded(this.resultados);

  @override
  List<Object?> get props => [resultados];
}

class BuscarIdInitial extends UsuarioState {}

class BuscarIdLoading extends UsuarioState {}

class BuscarIdSuccess extends UsuarioState {
  final UsuarioIdMensajeDtoResponse usuario;

  BuscarIdSuccess(this.usuario);
}

class BuscarIdError extends UsuarioState {
  final String mensaje;

  BuscarIdError(this.mensaje);
}