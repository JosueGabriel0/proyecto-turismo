import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_response.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_response.dart';

class FamiliaCategoriaState extends Equatable {
  const FamiliaCategoriaState();

  @override
  List<Object?> get props => [];
}

class FamiliaCategoriaInitial extends FamiliaCategoriaState {}
class FamiliaCategoriaLoading extends FamiliaCategoriaState {}

class FamiliaCategoriaLoaded extends FamiliaCategoriaState {
  final FamiliaCategoriaResponse familiaCategoriaResponse;

  const FamiliaCategoriaLoaded(this.familiaCategoriaResponse);
  @override
  List<Object?> get props => [familiaCategoriaResponse];
}

class FamiliaCategoriaListLoaded extends FamiliaCategoriaState {
  final List<FamiliaCategoriaDtoResponse> familiaCategoriaListResponse;

  const FamiliaCategoriaListLoaded(this.familiaCategoriaListResponse);
  @override
  List<Object?> get props => [familiaCategoriaListResponse];
}

class FamiliaCategoriaSuccess extends FamiliaCategoriaState {
  final String message;

  const FamiliaCategoriaSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class FamiliaCategoriaError extends FamiliaCategoriaState {
  final String message;

  const FamiliaCategoriaError(this.message);
  @override
  List<Object?> get props => [message];
}