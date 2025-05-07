import 'package:turismo_flutter/features/admin/data/models/lugar_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/lugar_respository.dart';

class GetLugaresUseCase {
  final LugarRepository lugarRepository;

  GetLugaresUseCase(this.lugarRepository);

  Future<List<LugarResponse>> call() async {
    return await lugarRepository.getLugares();
  }
}