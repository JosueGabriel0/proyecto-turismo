import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/rol_api_client.dart';
import 'package:turismo_flutter/features/admin/data/models/rol_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/rol_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/rol_repository.dart';

class RolRepositoryImpl implements RolRepository {
  final RolApiClient rolApiClient;

  // Constructor que recibe la instancia de RolApiClient
  RolRepositoryImpl({required this.rolApiClient});

  @override
  Future<List<RolResponse>> getRoles() async {
    final response = await rolApiClient.getRoles();
    print("Datos de roles: $response"); // Imprime la respuesta en la consola
    return response ?? []; // Asegúrate de no retornar null
  }

  @override
  Future<RolResponse> getRolById(int idRol) async {
    // Llamada a la API para obtener un rol por su ID
    final response = await rolApiClient.getRolById(idRol);
    return response;  // Retornamos el rol encontrado
  }

  @override
  Future<RolResponse> createRol(RolDto rolDto) async {
    // Llamada a la API para crear un nuevo rol
    final response = await rolApiClient.createRol(rolDto);
    return response;  // Retornamos el rol creado
  }

  @override
  Future<RolResponse> updateRol(int idRol, RolDto rolDto) async {
    // Llamada a la API para actualizar un rol existente
    final response = await rolApiClient.updateRol(idRol, rolDto);
    return response;  // Retornamos el rol actualizado
  }

  @override
  Future<void> deleteRol(int idRol) async {
    // Llamada a la API para eliminar un rol
    await rolApiClient.deleteRol(idRol);
  }

  @override
  Future<List<RolResponse>> buscarRolesPorNombre(String nombre) {
    return rolApiClient.buscarRolesPorNombre(nombre);
  }
}