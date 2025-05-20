import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';

class CategoriaState extends Equatable{
  const CategoriaState();

  @override
  List<Object?> get props => [];
}

class CategoriaInitial extends CategoriaState {}
class CategoriaLoading extends CategoriaState {}

class CategoriaListLoaded extends CategoriaState {
  final List<CategoriaResponse> categorias;
  const CategoriaListLoaded(this.categorias);

  @override
  List<Object?> get props => [categorias];
}

class CategoriaLoaded extends CategoriaState {
  final CategoriaResponse categoria;
  const CategoriaLoaded(this.categoria);

  @override
  List<Object?> get props => [categoria];
}

class CategoriaSuccess extends CategoriaState {
  final String message;
  const CategoriaSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CategoriaError extends CategoriaState{
  final String message;
  const CategoriaError(this.message);

  @override
  List<Object?> get props => [message];
}

class CategoriaSearchLoaded extends CategoriaState {
  final List<CategoriaResponse> resultados;

  const CategoriaSearchLoaded(this.resultados);

  @override
  List<Object?> get props => [resultados];
}
