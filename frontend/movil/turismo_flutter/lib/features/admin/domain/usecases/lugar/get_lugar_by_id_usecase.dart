import 'package:turismo_flutter/features/admin/data/models/lugar_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/lugar_respository.dart';

class GetLugarByIdUseCase {
  final LugarRepository lugarRepository;

  GetLugarByIdUseCase(this.lugarRepository);

  Future<LugarResponse> call(int id) async {
    return lugarRepository.getLugarById(id);
  }
}