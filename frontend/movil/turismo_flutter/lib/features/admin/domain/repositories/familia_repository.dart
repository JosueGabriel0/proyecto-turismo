import 'dart:io';

import 'package:dio/dio.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_response.dart';

abstract class FamiliaRepository{
  Future<List<FamiliaResponse>> getFamilias();
  Future<FamiliaResponse> getFamiliaById(int idFamilia);
  Future<FamiliaResponse> postFamilia(FamiliaDto familiaDto, File? file);
  Future<FamiliaResponse> putFamilia(int idFamilia, FamiliaDto familiaDto, File? file);
  Future<void> deleteFamilia(int idFamilia);
  Future<List<FamiliaResponse>> buscarFamiliasPorNombre(String nombre);
}