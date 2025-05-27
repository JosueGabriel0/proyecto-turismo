import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_post.dart';

class FamiliaCategoriaGeneralEvent extends Equatable{
  const FamiliaCategoriaGeneralEvent();

  @override
  List<Object?> get props => [];
}

class ListarRelacionesEventGeneral extends FamiliaCategoriaGeneralEvent{}

class ObtenerPorIdCategoriaEventGeneral extends FamiliaCategoriaGeneralEvent {
  final int idCategoria;
  const ObtenerPorIdCategoriaEventGeneral(this.idCategoria);

  @override
  List<Object?> get props => [idCategoria];
}

class ObtenerPorIdFamiliaEventGeneral extends FamiliaCategoriaGeneralEvent {
  final int idFamilia;
  const ObtenerPorIdFamiliaEventGeneral(this.idFamilia);

  @override
  List<Object?> get props => [idFamilia];
}

class GetEmprendimientosPorFamiliaCategoriaEvent extends FamiliaCategoriaGeneralEvent {
  final int idFamiliaCategoria;
  final String? nombre;

  const GetEmprendimientosPorFamiliaCategoriaEvent(this.idFamiliaCategoria, {this.nombre});

  @override
  List<Object?> get props => [idFamiliaCategoria, nombre];
}