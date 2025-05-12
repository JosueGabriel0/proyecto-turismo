import 'dart:io';

import 'package:turismo_flutter/features/admin/data/models/familia_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/familia_repository.dart';

class PutFamiliaUseCase{
  final FamiliaRepository familiaRepository;

  PutFamiliaUseCase(this.familiaRepository);

  Future<FamiliaResponse> call(int idFamilia, FamiliaDto familiaDto, File? file) async {
    return await familiaRepository.putFamilia(idFamilia, familiaDto, file);
  }
}