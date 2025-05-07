import 'dart:io';

import 'package:turismo_flutter/features/admin/data/models/lugar_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/lugar_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/lugar_respository.dart';

class CreateLugarUsecase{
  final LugarRepository lugarRepository;

  CreateLugarUsecase(this.lugarRepository);

  Future<LugarResponse> call(LugarDto lugarDto, File? imagen) async {
    return await lugarRepository.postLugar(lugarDto, imagen);
  }
}