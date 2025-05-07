import 'package:turismo_flutter/features/admin/data/models/rol_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/rol_repository.dart';

class GetRolesUseCase {
  final RolRepository rolRepository;

  GetRolesUseCase({required this.rolRepository});

  Future<List<RolResponse>> execute() async {
    final result = await rolRepository.getRoles();
    return result ?? [];
  }
}