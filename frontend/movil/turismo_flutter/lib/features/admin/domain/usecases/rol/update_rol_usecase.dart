import 'package:turismo_flutter/features/admin/data/models/rol_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/rol_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/rol_repository.dart';

class UpdateRolUseCase {
  final RolRepository rolRepository;

  UpdateRolUseCase({required this.rolRepository});

  Future<RolResponse> execute(int idRol, RolDto rolDto) async {
    return await rolRepository.updateRol(idRol, rolDto);
  }
}
