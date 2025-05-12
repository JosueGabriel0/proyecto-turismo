import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/categoria_repository.dart';

class GetCategoriasUsecase {
  final CategoriaRepository categoriaRepository;
  GetCategoriasUsecase(this.categoriaRepository);

  Future<List<CategoriaResponse>> call() async{
    return await categoriaRepository.getCategorias();
  }
}