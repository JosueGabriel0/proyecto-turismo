import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_post.dart';

class FamiliaCategoriaEvent extends Equatable{
  const FamiliaCategoriaEvent();

  @override
  List<Object?> get props => [];
}

class ListarRelacionesEvent extends FamiliaCategoriaEvent{}

class EliminarRelacionEvent extends FamiliaCategoriaEvent{
  final int idFamiliaCategoria;
  const EliminarRelacionEvent(this.idFamiliaCategoria);

  @override
  List<Object?> get props => [idFamiliaCategoria];
}

class AsociarFamiliaCategoriaEvent extends FamiliaCategoriaEvent{
  final FamiliaCategoriaDtoPost dto;
  const AsociarFamiliaCategoriaEvent(this.dto);

  @override
  List<Object?> get props => [dto];
}

class ObtenerPorIdCategoriaEvent extends FamiliaCategoriaEvent {
  final int idCategoria;
  const ObtenerPorIdCategoriaEvent(this.idCategoria);

  @override
  List<Object?> get props => [idCategoria];
}

class ObtenerPorIdFamiliaEvent extends FamiliaCategoriaEvent {
  final int idFamilia;
  const ObtenerPorIdFamiliaEvent(this.idFamilia);

  @override
  List<Object?> get props => [idFamilia];
}