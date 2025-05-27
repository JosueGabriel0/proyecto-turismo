import 'package:turismo_flutter/features/admin/data/models/familia_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/familia_repository.dart';
import 'package:turismo_flutter/features/general/data/models/familia_general_response.dart';
import 'package:turismo_flutter/features/general/domain/repositories/familia_general_repository.dart';

class GetFamiliasUsecaseGeneral {
  final FamiliaGeneralRepository familiaGeneralRepository;

  GetFamiliasUsecaseGeneral(this.familiaGeneralRepository);

  Future<List<FamiliaGeneralResponse>> call() async {
    return await familiaGeneralRepository.getFamiliasGeneral();
  }
}