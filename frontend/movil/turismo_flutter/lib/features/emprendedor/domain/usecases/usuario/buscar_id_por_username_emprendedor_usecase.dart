import 'package:turismo_flutter/features/emprendedor/data/models/usuario_id_mensaje_emprendedor_dto_response.dart';
import 'package:turismo_flutter/features/emprendedor/domain/repositories/usuario_emprendedor_repository.dart';

class BuscarIdPorUsernameEmprendedorUsecase {
  final UsuarioEmprendedorRepository repository;

  BuscarIdPorUsernameEmprendedorUsecase(this.repository);

  Future<UsuarioIdMensajeEmprendedorDtoResponse> call(String userName) {
    return repository.buscarIdPorUsername(userName);
  }
}
