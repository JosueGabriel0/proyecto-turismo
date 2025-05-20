import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/familia_categoria_repository.dart';

class ListarRelacionesUsecase {
  final FamiliaCategoriaRepository familiaCategoriaRepository;
  ListarRelacionesUsecase(this.familiaCategoriaRepository);

  Future<List<FamiliaCategoriaDtoResponse>> call() async{
    return await familiaCategoriaRepository.listarRelaciones();
  }
}