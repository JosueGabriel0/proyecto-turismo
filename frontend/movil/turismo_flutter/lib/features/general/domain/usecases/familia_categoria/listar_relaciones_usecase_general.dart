import 'package:turismo_flutter/features/admin/data/models/familia_categoria_dto_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/familia_categoria_repository.dart';
import 'package:turismo_flutter/features/general/data/models/familia_categoria_general_dto_response.dart';
import 'package:turismo_flutter/features/general/domain/repositories/familia_categoria_general_repository.dart';

class ListarRelacionesUsecaseGeneral {
  final FamiliaCategoriaGeneralRepository familiaCategoriaGeneralRepository;
  ListarRelacionesUsecaseGeneral(this.familiaCategoriaGeneralRepository);

  Future<List<FamiliaCategoriaGeneralDtoResponse>> call() async{
    return await familiaCategoriaGeneralRepository.listarRelacionesGeneral();
  }
}