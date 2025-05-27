import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/categoria_repository.dart';
import 'package:turismo_flutter/features/general/data/models/categoria_general_response.dart';
import 'package:turismo_flutter/features/general/domain/repositories/categoria_general_repository.dart';

class GetCategoriasUsecaseGeneral {
  final CategoriaGeneralRepository categoriaGeneralRepository;
  GetCategoriasUsecaseGeneral(this.categoriaGeneralRepository);

  Future<List<CategoriaGeneralResponse>> call() async{
    return await categoriaGeneralRepository.getCategoriasGeneral();
  }
}