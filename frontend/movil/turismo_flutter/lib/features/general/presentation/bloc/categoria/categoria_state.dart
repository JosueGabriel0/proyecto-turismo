import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';
import 'package:turismo_flutter/features/general/data/models/categoria_general_response.dart';

class CategoriaGeneralState extends Equatable{
  const CategoriaGeneralState();

  @override
  List<Object?> get props => [];
}

class CategoriaInitialGeneral extends CategoriaGeneralState {}
class CategoriaLoadingGeneral extends CategoriaGeneralState {}

class CategoriaListLoadedGeneral extends CategoriaGeneralState {
  final List<CategoriaGeneralResponse> categorias;
  const CategoriaListLoadedGeneral(this.categorias);

  @override
  List<Object?> get props => [categorias];
}

class CategoriaLoadedGeneral extends CategoriaGeneralState {
  final CategoriaGeneralResponse categoria;
  const CategoriaLoadedGeneral(this.categoria);

  @override
  List<Object?> get props => [categoria];
}

class CategoriaSuccessGeneral extends CategoriaGeneralState {
  final String message;
  const CategoriaSuccessGeneral(this.message);

  @override
  List<Object?> get props => [message];
}

class CategoriaErrorGeneral extends CategoriaGeneralState{
  final String message;
  const CategoriaErrorGeneral(this.message);

  @override
  List<Object?> get props => [message];
}

class CategoriaSearchLoadedGeneral extends CategoriaGeneralState {
  final List<CategoriaGeneralResponse> resultados;

  const CategoriaSearchLoadedGeneral(this.resultados);

  @override
  List<Object?> get props => [resultados];
}
