import 'package:turismo_flutter/features/admin/data/models/familia_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/familia_repository.dart';
import 'package:turismo_flutter/features/general/data/models/familia_general_response.dart';
import 'package:turismo_flutter/features/general/domain/repositories/familia_general_repository.dart';

class GetFamiliaByIdUsecaseGeneral {
  final FamiliaGeneralRepository familiaGeneralRepository;
  GetFamiliaByIdUsecaseGeneral(this.familiaGeneralRepository);

  Future<FamiliaGeneralResponse> call(int idFamilia) async {
    return await familiaGeneralRepository.getFamiliaByIdGeneral(idFamilia);
  }
}