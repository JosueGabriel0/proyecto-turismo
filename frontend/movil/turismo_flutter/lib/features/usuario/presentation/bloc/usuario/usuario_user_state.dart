import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_id_mensaje_usuario_dto_response.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_user_response.dart';

abstract class UsuarioUserState extends Equatable {
  const UsuarioUserState();

  @override
  List<Object?> get props => [];
}

class UsuarioUserInitial extends UsuarioUserState {}

class UsuarioUserLoading extends UsuarioUserState {}

class UsuarioUserProfileLoaded extends UsuarioUserState {
  final UsuarioUserResponse usuario;
  const UsuarioUserProfileLoaded(this.usuario);

  @override
  List<Object?> get props => [usuario];
}

class UsuarioUserSuccess extends UsuarioUserState {
  final String message;
  const UsuarioUserSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class UsuarioUserError extends UsuarioUserState {
  final String message;
  const UsuarioUserError(this.message);
  @override
  List<Object?> get props => [message];
}

class BuscarIdInitialUser extends UsuarioUserState {}

class BuscarIdLoadingUser extends UsuarioUserState {}

class BuscarIdSuccessUser extends UsuarioUserState {
  final UsuarioIdMensajeUsuarioDtoResponse usuario;

  BuscarIdSuccessUser(this.usuario);
}

class BuscarIdErrorUser extends UsuarioUserState {
  final String mensaje;

  BuscarIdErrorUser(this.mensaje);
}