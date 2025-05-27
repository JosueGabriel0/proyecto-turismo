import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/categoria_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';

class CategoriaGeneralEvent extends Equatable {
  const CategoriaGeneralEvent();

  @override
  List<Object?> get props => [];
}

class GetCategoriasGeneralEvent extends CategoriaGeneralEvent {
  const GetCategoriasGeneralEvent();

  @override
  List<Object?> get props => [];
}

class GetCategoriaByIdGeneralEvent extends CategoriaGeneralEvent {
  final int idCategoria;

  const GetCategoriaByIdGeneralEvent(this.idCategoria);

  @override
  List<Object?> get props => [idCategoria];
}

class BuscarCategoriasPorNombreGeneralEvent extends CategoriaGeneralEvent {
  final String nombre;

  const BuscarCategoriasPorNombreGeneralEvent(this.nombre);

  @override
  List<Object?> get props => [nombre];
}
