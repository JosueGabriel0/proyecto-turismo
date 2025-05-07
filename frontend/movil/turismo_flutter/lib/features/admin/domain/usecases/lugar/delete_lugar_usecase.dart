import 'package:turismo_flutter/features/admin/domain/repositories/lugar_respository.dart';

class DeleteLugarUseCase {
  final LugarRepository lugarRepository;

  DeleteLugarUseCase(this.lugarRepository);

  Future<void> call(int id) async {
    return await lugarRepository.deleteLugar(id);
  }
}