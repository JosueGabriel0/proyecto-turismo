import 'dart:io';

import 'package:turismo_flutter/features/admin/data/models/categoria_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';

abstract class CategoriaRepository{
  Future<List<CategoriaResponse>> getCategorias();
  Future<CategoriaResponse> getCategoriaById(int idCategoria);
  Future<CategoriaResponse> postCategoria(CategoriaDto categoriaDto, File? file);
  Future<CategoriaResponse> putCategoria(int idCategoria, CategoriaDto categoriaDto, File? file);
  Future<void> deleteCategoria(int idCategoria);
  Future<List<CategoriaResponse>> buscarCategoriasPorNombre(String nombre);
}