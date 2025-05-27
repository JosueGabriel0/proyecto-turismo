import 'package:turismo_flutter/features/admin/data/models/lugar_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/lugar_respository.dart';
import 'package:turismo_flutter/features/general/data/models/lugar_general_response.dart';
import 'package:turismo_flutter/features/general/domain/repositories/lugar_general_respository.dart';

class GetLugaresGeneralUsecase {
  final LugarGeneralRespository lugarRepository;

  GetLugaresGeneralUsecase(this.lugarRepository);

  Future<List<LugarGeneralResponse>> call() async {
    return await lugarRepository.getLugaresGeneral();
  }
}