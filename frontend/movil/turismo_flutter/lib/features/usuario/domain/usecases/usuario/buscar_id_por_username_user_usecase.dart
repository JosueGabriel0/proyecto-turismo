import 'package:turismo_flutter/features/usuario/data/models/usuario_id_mensaje_usuario_dto_response.dart';
import 'package:turismo_flutter/features/usuario/domain/repositories/usuario_user_repository.dart';

class BuscarIdPorUsernameUserUsecase {
  final UsuarioUserRepository repository;

  BuscarIdPorUsernameUserUsecase(this.repository);

  Future<UsuarioIdMensajeUsuarioDtoResponse> call(String userName) {
    return repository.buscarIdPorUsername(userName);
  }
}
