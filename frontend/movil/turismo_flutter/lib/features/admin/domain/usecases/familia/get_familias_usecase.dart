import 'package:turismo_flutter/features/admin/data/models/familia_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/familia_repository.dart';

class GetFamiliasUsecase {
  final FamiliaRepository familiaRepository;

  GetFamiliasUsecase(this.familiaRepository);

  Future<List<FamiliaResponse>> call() async {
    return await familiaRepository.getFamilias();
  }
}