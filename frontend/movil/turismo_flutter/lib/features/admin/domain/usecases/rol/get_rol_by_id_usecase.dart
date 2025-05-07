import 'package:turismo_flutter/features/admin/data/models/rol_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/rol_repository.dart';

class GetRolByIdUseCase {
  final RolRepository rolRepository;

  GetRolByIdUseCase({required this.rolRepository});

  Future<RolResponse> execute(int idRol) async {
    return await rolRepository.getRolById(idRol);
  }
}
