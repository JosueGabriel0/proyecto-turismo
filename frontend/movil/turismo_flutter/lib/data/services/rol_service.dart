import 'package:turismo_flutter/data/models/rol_response.dart';
import 'package:turismo_flutter/data/repositories_impl/rol_repository.dart';

class RolService {
  final RolRepository _repository = RolRepository();
  
  Future<List<RolResponse>> obtenerRoles(String token) async {
    return await _repository.getRoles(token);
  }
  
  Future<RolResponse> obtenerRolPorId(int idRol, String token) async {
    return await _repository.getRolById(idRol, token);
  }
}