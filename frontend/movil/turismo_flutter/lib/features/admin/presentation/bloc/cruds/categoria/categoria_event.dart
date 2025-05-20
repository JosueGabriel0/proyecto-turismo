import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/categoria_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';

class CategoriaEvent extends Equatable {
  const CategoriaEvent();

  @override
  List<Object?> get props => [];
}

class GetCategoriasEvent extends CategoriaEvent {
  const GetCategoriasEvent();

  @override
  List<Object?> get props => [];
}

class GetCategoriaByIdEvent extends CategoriaEvent {
  final int idCategoria;

  const GetCategoriaByIdEvent(this.idCategoria);

  @override
  List<Object?> get props => [idCategoria];
}

class PostCategoriaEvent extends CategoriaEvent {
  final CategoriaDto categoriaDto;
  final File? file;

  const PostCategoriaEvent(this.categoriaDto, this.file);

  @override
  List<Object?> get props => [categoriaDto, file];
}

class PutCategoriaEvent extends CategoriaEvent {
  final int idCategoria;
  final CategoriaDto categoriaDto;
  final File? file;

  const PutCategoriaEvent(this.idCategoria, this.categoriaDto, this.file);

  @override
  List<Object?> get props => [idCategoria, categoriaDto, file];
}

class DeleteCategoriaEvent extends CategoriaEvent {
  final int idCategoria;
  const DeleteCategoriaEvent(this.idCategoria);

  @override
  List<Object?> get props => [idCategoria];
}

class BuscarCategoriasPorNombreEvent extends CategoriaEvent {
  final String nombre;

  const BuscarCategoriasPorNombreEvent(this.nombre);

  @override
  List<Object?> get props => [nombre];
}
