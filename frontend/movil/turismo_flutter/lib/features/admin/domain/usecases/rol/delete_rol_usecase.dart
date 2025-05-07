import 'package:turismo_flutter/features/admin/domain/repositories/rol_repository.dart';

class DeleteRolUseCase {
  final RolRepository rolRepository;

  DeleteRolUseCase({required this.rolRepository});

  Future<void> execute(int idRol) async {
    return await rolRepository.deleteRol(idRol);
  }
}
