import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/rol_response.dart';

abstract class RolState extends Equatable {
  const RolState();
  @override
  List<Object?> get props => [];
}

class RolInitialState extends RolState {}

class RolLoadingState extends RolState {}

class RolLoadedState extends RolState {
  final List<RolResponse> roles;

  RolLoadedState({required this.roles});

  @override
  List<Object?> get props => [roles];
}

class RolErrorState extends RolState {
  final String message;

  RolErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class RolCreateSuccessState extends RolState {}

class RolUpdateSuccessState extends RolState {}

class RolDeleteSuccessState extends RolState {}

class RolSearchLoaded extends RolState {
  final List<RolResponse> resultados;

  const RolSearchLoaded(this.resultados);

  @override
  List<Object?> get props => [resultados];
}
