import 'dart:io';

import 'package:turismo_flutter/features/admin/data/models/categoria_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/categoria_repository.dart';

class PostCategoriaUsecase{
  final CategoriaRepository categoriaRepository;
  PostCategoriaUsecase(this.categoriaRepository);

  Future<CategoriaResponse> call(CategoriaDto categoriaDto, File? file) async {
    return await categoriaRepository.postCategoria(categoriaDto, file);
  }
}