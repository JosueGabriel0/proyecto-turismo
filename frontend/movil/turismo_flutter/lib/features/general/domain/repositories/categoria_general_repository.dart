import 'dart:io';

import 'package:turismo_flutter/features/admin/data/models/categoria_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';
import 'package:turismo_flutter/features/general/data/models/categoria_general_response.dart';

abstract class CategoriaGeneralRepository{
  Future<List<CategoriaGeneralResponse>> getCategoriasGeneral();
  Future<CategoriaGeneralResponse> getCategoriaByIdGeneral(int idCategoria);
  Future<List<CategoriaGeneralResponse>> buscarCategoriasPorNombreGeneral(String nombre);
}