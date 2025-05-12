import 'dart:io';

import 'package:turismo_flutter/features/admin/data/models/familia_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/familia_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/familia_repository.dart';

class PostFamiliaUsecase {
  final FamiliaRepository familiaRepository;

  PostFamiliaUsecase(this.familiaRepository);

  Future<FamiliaResponse> call(FamiliaDto familiaDto, File? file) async {
    return await familiaRepository.postFamilia(familiaDto, file);
  }
}