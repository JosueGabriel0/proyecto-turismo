import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/familia_categoria_api_client.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_post.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_response.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/familia_categoria_repository.dart';
import 'package:turismo_flutter/features/general/data/datasources/remote/familia_categoria_general_api_client.dart';
import 'package:turismo_flutter/features/general/data/models/emprendimiento_general_response.dart';
import 'package:turismo_flutter/features/general/data/models/familia_categoria_general_dto_response.dart';
import 'package:turismo_flutter/features/general/domain/repositories/familia_categoria_general_repository.dart';

class FamiliaCategoriaGeneralRepositoryImpl implements FamiliaCategoriaGeneralRepository {
  final FamiliaCategoriaGeneralApiClient familiaCategoriaApiClient;
  FamiliaCategoriaGeneralRepositoryImpl(this.familiaCategoriaApiClient);

  @override
  Future<List<FamiliaCategoriaGeneralDtoResponse>> listarRelacionesGeneral() {
    return familiaCategoriaApiClient.listarRelaciones();
  }

  @override
  Future<List<FamiliaCategoriaGeneralDtoResponse>> obtenerFamiliaCategoriaPorIdCategoriaGeneral(int idCategoria) {
    return familiaCategoriaApiClient.obtenerFamiliaCategoriaPorIdCategoria(idCategoria);
  }

  @override
  Future<List<FamiliaCategoriaGeneralDtoResponse>> obtenerFamiliaCategoriaPorIdFamiliaGeneral(int idFamilia) async {
    final result = await familiaCategoriaApiClient.obtenerFamiliaCategoriaPorIdFamilia(idFamilia);
    print("Repository - datos recibidos para familia $idFamilia: ${result.map((e) => e.idCategoria).toList()}");
    return result;
  }

  @override
  Future<List<EmprendimientoGeneralResponse>> obtenerEmprendimientosPorFamiliaCategoria(int idFamiliaCategoria, String? nombre) {
    return familiaCategoriaApiClient.getEmprendimientosPorFamiliaCategoria(idFamiliaCategoria, nombre);
  }
}