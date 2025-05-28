import 'package:turismo_flutter/features/general/data/models/servicio_turistico_response_general.dart';

abstract class ServicioTuristicoGeneralRepository {
  Future<List<ServicioTuristicoResponseGeneral>> getServiciosPorEmprendimiento(int idEmprendimiento);
}
