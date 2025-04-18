import 'package:turismo_flutter/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/data/repositories_impl/usuario_repository.dart';

class UsuarioService {
  final UsuarioRepository _repository = UsuarioRepository();

  Future<List<UsuarioCompletoResponse>> obtenerUsuarios(String token) async {
    return await _repository.getUsuariosCompletos(token);
  }

  Future<UsuarioCompletoResponse> obtenerUsuarioPorId(String token, int idUsuario) async {
    return await _repository.getUsuarioPorId(idUsuario, token);
  }
}