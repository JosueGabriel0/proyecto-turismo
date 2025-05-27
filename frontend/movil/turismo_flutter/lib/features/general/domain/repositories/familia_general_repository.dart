import 'dart:io';

import 'package:dio/dio.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_response.dart';
import 'package:turismo_flutter/features/general/data/models/familia_general_response.dart';

abstract class FamiliaGeneralRepository{
  Future<List<FamiliaGeneralResponse>> getFamiliasGeneral();
  Future<FamiliaGeneralResponse> getFamiliaByIdGeneral(int idFamilia);
  Future<List<FamiliaGeneralResponse>> buscarFamiliasPorNombreGeneral(String nombre);
}