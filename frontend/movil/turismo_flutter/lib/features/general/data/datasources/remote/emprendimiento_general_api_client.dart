import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:turismo_flutter/features/general/data/models/emprendimiento_general_response.dart';

part 'emprendimiento_general_api_client.g.dart';

@RestApi()
abstract class EmprendimientoGeneralApiClient {
  factory EmprendimientoGeneralApiClient(Dio dio, {String baseUrl}) = _EmprendimientoGeneralApiClient;

  @GET("/general/emprendimiento")
  Future<List<EmprendimientoGeneralResponse>> getEmprendimientos();

  @GET("/general/emprendimiento/buscar")
  Future<List<EmprendimientoGeneralResponse>> buscarEmprendimientosPorNombre(
      @Query("nombre") String nombre,
      );

  @GET("/general/emprendimiento/{idEmprendimiento}")
  Future<EmprendimientoGeneralResponse> getEmprendimientoById(@Path("idEmprendimiento") int idEmprendimiento);
}