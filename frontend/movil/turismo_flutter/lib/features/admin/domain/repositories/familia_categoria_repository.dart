import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_post.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_response.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_response.dart';

abstract class FamiliaCategoriaRepository {
  Future<FamiliaCategoriaResponse> asociarFamiliaConCategoria(FamiliaCategoriaDtoPost dto);
  Future<List<FamiliaCategoriaDtoResponse>> listarRelaciones();
  Future<List<FamiliaCategoriaDtoResponse>> obtenerFamiliaCategoriaPorIdFamilia(int idFamilia);
  Future<List<FamiliaCategoriaDtoResponse>> obtenerFamiliaCategoriaPorIdCategoria(int idCategoria);
  Future<void> eliminarRelacion(int idFamiliaCategoria);
}