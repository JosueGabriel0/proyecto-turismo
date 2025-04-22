import 'package:turismo_flutter/data/models/usuario_completo_dto.dart';
import 'package:turismo_flutter/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/data/repositories_impl/usuario_repository.dart';

class UsuarioService {
  final UsuarioRepository _repository;

  UsuarioService({UsuarioRepository? repository})
      : _repository = repository ?? UsuarioRepository();

  Future<List<UsuarioCompletoResponse>> obtenerUsuarios() {
    return _repository.getUsuariosCompletos();
  }

  Future<UsuarioCompletoResponse> obtenerUsuarioPorId(int idUsuario) {
    return _repository.getUsuarioPorId(idUsuario);
  }

  Future<UsuarioCompletoResponse> crearUsuario(UsuarioCompletoDto dto) {
    return _repository.createUsuario(dto);
  }

  Future<UsuarioCompletoResponse> actualizarUsuario(int idUsuario, UsuarioCompletoDto dto) {
    return _repository.updateUsuario(idUsuario, dto);
  }

  Future<void> eliminarUsuario(int idUsuario) {
    return _repository.deleteUsuario(idUsuario);
  }
}