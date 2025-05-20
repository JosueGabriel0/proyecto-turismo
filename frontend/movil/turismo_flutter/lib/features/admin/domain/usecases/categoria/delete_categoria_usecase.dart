import 'package:turismo_flutter/features/admin/domain/repositories/categoria_repository.dart';

class DeleteCategoriaUseCase {
  final CategoriaRepository categoriaRepository;

  DeleteCategoriaUseCase(this.categoriaRepository);

  Future<void> call(int idCategoria) async {
    await categoriaRepository.deleteCategoria(idCategoria);
  }
}