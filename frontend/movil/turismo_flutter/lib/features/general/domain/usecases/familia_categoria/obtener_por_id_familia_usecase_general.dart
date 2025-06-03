import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/familia_categoria_repository.dart';
import 'package:turismo_flutter/features/general/data/models/familia_categoria_general_dto_response.dart';
import 'package:turismo_flutter/features/general/domain/repositories/familia_categoria_general_repository.dart';

class ObtenerPorIdFamiliaUsecaseGeneral {
  final FamiliaCategoriaGeneralRepository familiaCategoriaGeneralRepository;
  ObtenerPorIdFamiliaUsecaseGeneral(this.familiaCategoriaGeneralRepository);

  Future<List<FamiliaCategoriaGeneralDtoResponse>> call(int idFamilia) async {
    final result = await familiaCategoriaGeneralRepository.obtenerFamiliaCategoriaPorIdFamiliaGeneral(idFamilia);
    print("Usecase - datos obtenidos para familia $idFamilia: ${result.map((e) => e.idCategoria).toList()}");
    return result;
  }
}