import 'package:turismo_flutter/data/models/rol_dto.dart';
import 'package:turismo_flutter/data/models/rol_response.dart';
import 'package:turismo_flutter/data/repositories_impl/rol_repository.dart';

class RolService {
  final RolRepository _repository = RolRepository();

  Future<List<RolResponse>> obtenerRoles() async {
    return await _repository.getRoles();
  }

  Future<RolResponse> obtenerRolPorId(int idRol) async {
    return await _repository.getRolById(idRol);
  }

  Future<void> eliminarRol(int idRol) async {
    await _repository.deleteRol(idRol);
  }

  Future<RolResponse> crearRol(RolDto rolDto) async {
    // Llamar al repositorio para crear el rol
    final response = await _repository.createRol(rolDto);
    // El repositorio ya te devuelve un objeto RolResponse, así que no es necesario mapearlo otra vez
    return response;
  }

  // Método para actualizar el rol
  Future<RolResponse> actualizarRol(int idRol, RolDto rolDto) async {
    return await _repository.updateRol(idRol, rolDto);
  }
}