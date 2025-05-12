import 'package:turismo_flutter/features/admin/data/models/familia_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/familia_repository.dart';

class GetFamiliaByIdUsecase {
  final FamiliaRepository familiaRepository;
  GetFamiliaByIdUsecase(this.familiaRepository);

  Future<FamiliaResponse> call(int idFamilia) async {
    return await familiaRepository.getFamiliaById(idFamilia);
  }
}