import 'package:turismo_flutter/features/general/data/models/familia_general_response.dart';
import 'package:turismo_flutter/features/general/data/models/lugar_general_response.dart';

abstract class LugarGeneralRespository {
  Future<List<LugarGeneralResponse>> getLugaresGeneral();
  Future<List<LugarGeneralResponse>> buscarLugaresPorNombreGeneral(String nombre);
  Future<List<FamiliaGeneralResponse>> getFamiliasPorLugar(int idLugar, String? nombre);
}