import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/familia_categoria_api_client.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_post.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_response.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/familia_categoria_repository.dart';

class FamiliaCategoriaRepositoryImpl implements FamiliaCategoriaRepository {
  final FamiliaCategoriaApiClient familiaCategoriaApiClient;
  FamiliaCategoriaRepositoryImpl(this.familiaCategoriaApiClient);
  
  @override
  Future<FamiliaCategoriaResponse> asociarFamiliaConCategoria(FamiliaCategoriaDtoPost dto) {
    return familiaCategoriaApiClient.asociarFamiliaConCategoria(dto);
  }

  @override
  Future<void> eliminarRelacion(int idFamiliaCategoria) {
    return familiaCategoriaApiClient.eliminarRelacion(idFamiliaCategoria);
  }

  @override
  Future<List<FamiliaCategoriaDtoResponse>> listarRelaciones() {
    return familiaCategoriaApiClient.listarRelaciones();
  }

  @override
  Future<List<FamiliaCategoriaDtoResponse>> obtenerFamiliaCategoriaPorIdCategoria(int idCategoria) {
    return familiaCategoriaApiClient.obtenerFamiliaCategoriaPorIdCategoria(idCategoria);
  }

  @override
  Future<List<FamiliaCategoriaDtoResponse>> obtenerFamiliaCategoriaPorIdFamilia(int idFamilia) {
    return familiaCategoriaApiClient.obtenerFamiliaCategoriaPorIdFamilia(idFamilia);
  }

}