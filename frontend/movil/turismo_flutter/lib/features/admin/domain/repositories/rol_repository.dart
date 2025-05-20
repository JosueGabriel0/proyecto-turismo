import 'package:turismo_flutter/features/admin/data/models/rol_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/rol_response.dart';

abstract class RolRepository {
  Future<List<RolResponse>> getRoles();  // Obtener todos los roles
  Future<RolResponse> getRolById(int idRol);  // Obtener un rol por ID
  Future<RolResponse> createRol(RolDto rolDto);  // Crear un nuevo rol
  Future<RolResponse> updateRol(int idRol, RolDto rolDto);  // Actualizar un rol
  Future<void> deleteRol(int idRol);  // Eliminar un rol
  Future<List<RolResponse>> buscarRolesPorNombre(String nombre);
}