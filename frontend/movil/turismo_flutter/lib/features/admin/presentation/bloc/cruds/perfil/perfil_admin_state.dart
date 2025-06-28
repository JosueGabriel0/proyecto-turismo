import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_response.dart';

abstract class PerfilAdminState extends Equatable {
  const PerfilAdminState();
  @override
  List<Object?> get props => [];
}

class PerfilAdminInitial extends PerfilAdminState {}

class PerfilAdminLoading extends PerfilAdminState {}

class PerfilAdminLoaded extends PerfilAdminState {
  final UsuarioCompletoResponse usuario;
  const PerfilAdminLoaded(this.usuario);

  @override
  List<Object?> get props => [usuario];
}

class PerfilAdminUpdated extends PerfilAdminState {
  final String message;
  const PerfilAdminUpdated(this.message);

  @override
  List<Object?> get props => [message];
}

class PerfilAdminError extends PerfilAdminState {
  final String message;
  const PerfilAdminError(this.message);

  @override
  List<Object?> get props => [message];
}
