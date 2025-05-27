import 'package:turismo_flutter/features/admin/domain/repositories/lugar_respository.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/servicio_turistico_repository.dart';

class DeleteServicioTuristicoUsecase {
  final ServicioTuristicoRepository servicioTuristicoRepository;

  DeleteServicioTuristicoUsecase(this.servicioTuristicoRepository);

  Future<void> call(int id) async {
    return await servicioTuristicoRepository.deleteServicioTuristico(id);
  }
}