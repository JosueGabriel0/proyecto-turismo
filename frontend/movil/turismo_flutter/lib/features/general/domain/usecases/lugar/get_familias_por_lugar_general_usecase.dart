import 'package:turismo_flutter/features/general/data/models/familia_general_response.dart';
import 'package:turismo_flutter/features/general/data/repositories/lugar_general_repository_impl.dart';
import 'package:turismo_flutter/features/general/domain/repositories/lugar_general_respository.dart';

class GetFamiliasPorLugarGeneralUsecase{
  final LugarGeneralRespository lugarRepository;

  GetFamiliasPorLugarGeneralUsecase(this.lugarRepository);

  Future<List<FamiliaGeneralResponse>> call(int idLugar, String? nombre) async {
    return await lugarRepository.getFamiliasPorLugar(idLugar, nombre);
  }
}