import 'package:turismo_flutter/features/admin/data/models/rol_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/rol_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/rol_repository.dart';

class CreateRolUseCase {
  final RolRepository rolRepository;

  CreateRolUseCase({required this.rolRepository});

  Future<RolResponse> execute(RolDto rolDto) async {
    return await rolRepository.createRol(rolDto);
  }
}
