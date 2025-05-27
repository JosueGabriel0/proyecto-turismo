import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_post.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_response.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_categoria_response.dart';
import 'package:turismo_flutter/features/general/data/models/emprendimiento_general_response.dart';
import 'package:turismo_flutter/features/general/data/models/familia_categoria_general_dto_response.dart';
import 'package:turismo_flutter/features/general/data/models/familia_categoria_general_response.dart';

abstract class FamiliaCategoriaGeneralRepository {
  Future<List<FamiliaCategoriaGeneralDtoResponse>> listarRelacionesGeneral();
  Future<List<FamiliaCategoriaGeneralDtoResponse>> obtenerFamiliaCategoriaPorIdFamiliaGeneral(int idFamilia);
  Future<List<FamiliaCategoriaGeneralDtoResponse>> obtenerFamiliaCategoriaPorIdCategoriaGeneral(int idCategoria);
  Future<List<EmprendimientoGeneralResponse>> obtenerEmprendimientosPorFamiliaCategoria(int idFamiliaCategoria, String? nombre);
}