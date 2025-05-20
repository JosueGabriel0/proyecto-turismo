import 'package:turismo_flutter/features/admin/domain/repositories/familia_categoria_repository.dart';

class EliminarRelacionUsecase {
  final FamiliaCategoriaRepository familiaCategoriaRepository;
  EliminarRelacionUsecase(this.familiaCategoriaRepository);

  Future<void> call(int idFamiliaCategoria) async{
    return await familiaCategoriaRepository.eliminarRelacion(idFamiliaCategoria);
  }
}