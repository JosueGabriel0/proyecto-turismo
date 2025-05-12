import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/categoria_repository.dart';

class GetCategoriaByIdUsecase {
  final CategoriaRepository categoriaRepository;
  GetCategoriaByIdUsecase(this.categoriaRepository);

  Future<CategoriaResponse> call(int idCategoria) async {
    return await categoriaRepository.getCategoriaById(idCategoria);
  }
}