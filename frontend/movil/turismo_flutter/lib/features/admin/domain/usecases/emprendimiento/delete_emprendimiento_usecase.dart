import 'package:turismo_flutter/features/admin/domain/repositories/emprendimiento_repository.dart';

class DeleteEmprendimientoUseCase {
  final EmprendimientoRepository emprendimientoRepository;

  DeleteEmprendimientoUseCase(this.emprendimientoRepository);

  Future<void> call(int idEmprendimiento) async {
    await emprendimientoRepository.deleteEmprendimiento(idEmprendimiento);
  }
}