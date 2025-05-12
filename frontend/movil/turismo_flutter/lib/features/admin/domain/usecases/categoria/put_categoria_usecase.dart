import 'dart:io';

import 'package:turismo_flutter/features/admin/data/models/categoria_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/categoria_repository.dart';

class PutCategoriaUsecase {
  final CategoriaRepository categoriaRepository;
  PutCategoriaUsecase(this.categoriaRepository);

  Future<CategoriaResponse> call(int idCategoria, CategoriaDto categoriaDto, File? file) async {
    return await categoriaRepository.putCategoria(idCategoria, categoriaDto, file);
  }
}