import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/familia_categoria_repository.dart';

class ObtenerPorIdCategoriaUsecase {
  final FamiliaCategoriaRepository familiaCategoriaRepository;
  ObtenerPorIdCategoriaUsecase(this.familiaCategoriaRepository);

  Future<List<FamiliaCategoriaDtoResponse>> call(int idCategoria) async{
    return await familiaCategoriaRepository.obtenerFamiliaCategoriaPorIdCategoria(idCategoria);
  }
}