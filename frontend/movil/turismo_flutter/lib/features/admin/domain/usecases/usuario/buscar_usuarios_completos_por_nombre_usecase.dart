import 'package:turismo_flutter/features/admin/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/usuario_repository.dart';

class BuscarUsuariosCompletosPorNombreUsecase {
  final UsuarioRepository repository;

  BuscarUsuariosCompletosPorNombreUsecase(this.repository);

  Future<List<UsuarioCompletoResponse>> call(String username) {
    return repository.buscarUsuariosCompletosPorNombre(username);
  }
}