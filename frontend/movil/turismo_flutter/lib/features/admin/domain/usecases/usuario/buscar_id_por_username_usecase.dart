import 'package:turismo_flutter/features/admin/data/models/usuario_id_mensaje_dto_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/usuario_repository.dart';

class BuscarIdPorUsernameUsecase {
  final UsuarioRepository repository;

  BuscarIdPorUsernameUsecase(this.repository);

  Future<UsuarioIdMensajeDtoResponse> call(String userName) {
    return repository.buscarIdPorUsername(userName);
  }
}
