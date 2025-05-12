  import 'package:turismo_flutter/features/admin/domain/repositories/familia_repository.dart';

class DeleteFamiliaUsecase {
  final FamiliaRepository familiaRepository;
  DeleteFamiliaUsecase(this.familiaRepository);

  Future<void> call(int idFamilia) async {
    await familiaRepository.deleteFamilia(idFamilia);
  }
}