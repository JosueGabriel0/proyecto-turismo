import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_response.dart';

class FamiliaState extends Equatable {
  const FamiliaState();

  @override
  List<Object?> get props => [];
}

class FamiliaInitial extends FamiliaState {}
class FamiliaLoading extends FamiliaState {}

class FamiliaLoaded extends FamiliaState {
  final FamiliaResponse familiaResponse;
  const FamiliaLoaded(this.familiaResponse);

  @override
  List<Object?> get props => [familiaResponse];
}

class FamiliaListLoaded extends FamiliaState {
  final List<FamiliaResponse> familiaListResponse;
  const FamiliaListLoaded(this.familiaListResponse);

  @override
  List<Object?> get props => [familiaListResponse];
}

class FamiliaSuccess extends FamiliaState {
  final String message;
  const FamiliaSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class FamiliaError extends FamiliaState {
  final String message;
  const FamiliaError(this.message);

  @override
  List<Object?> get props => [message];
}

class FamiliaSearchLoaded extends FamiliaState {
  final List<FamiliaResponse> resultados;

  const FamiliaSearchLoaded(this.resultados);

  @override
  List<Object?> get props => [resultados];
}