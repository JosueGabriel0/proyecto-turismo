import 'package:turismo_flutter/features/general/data/models/emprendimiento_general_response.dart';
import 'package:turismo_flutter/features/general/domain/repositories/familia_categoria_general_repository.dart';

class GetEmprendimientosPorFamiliaCategoriaUsecaseGeneral{
  final FamiliaCategoriaGeneralRepository familiaCategoriaGeneralRepository;

  GetEmprendimientosPorFamiliaCategoriaUsecaseGeneral(this.familiaCategoriaGeneralRepository);

  Future<List<EmprendimientoGeneralResponse>> call(int idFamiliaCategoria, String? nombre) async {
    return await familiaCategoriaGeneralRepository.obtenerEmprendimientosPorFamiliaCategoria(idFamiliaCategoria, nombre);
  }
}