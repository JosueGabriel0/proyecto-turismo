import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_post.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/familia_categoria_repository.dart';

class AsociarFamiliaCategoriaUseCase {
  final FamiliaCategoriaRepository familiaCategoriaRepository;
  AsociarFamiliaCategoriaUseCase(this.familiaCategoriaRepository);

  Future<FamiliaCategoriaResponse> call(FamiliaCategoriaDtoPost dto) async{
    return await familiaCategoriaRepository.asociarFamiliaConCategoria(dto);
  }
}