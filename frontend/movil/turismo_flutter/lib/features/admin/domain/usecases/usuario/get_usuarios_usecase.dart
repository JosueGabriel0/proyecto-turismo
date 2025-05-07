import 'package:turismo_flutter/features/admin/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/usuario_repository.dart';

class GetAllUsuariosUseCase {
  final UsuarioRepository repository;

  GetAllUsuariosUseCase(this.repository);

  Future<List<UsuarioCompletoResponse>> call() {
    return repository.getUsuariosCompleto();
  }
}
