import 'dart:io';

import 'package:turismo_flutter/features/admin/data/models/lugar_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/lugar_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/lugar_respository.dart';

class UpdateLugarUseCase {
  final LugarRepository lugarRepository;

  UpdateLugarUseCase(this.lugarRepository);

  Future<LugarResponse> call(int id, LugarDto lugardto, File? imagen) async {
    return await lugarRepository.putLugar(id, lugardto, imagen);
  }
}