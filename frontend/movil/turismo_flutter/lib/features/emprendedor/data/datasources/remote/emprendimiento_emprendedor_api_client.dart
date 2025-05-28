import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/emprendimiento_emprendedor_response.dart';

part 'emprendimiento_emprendedor_api_client.g.dart';

@RestApi()
abstract class EmprendimientoEmprendedorApiClient {
  factory EmprendimientoEmprendedorApiClient(Dio dio, {String baseUrl}) = _EmprendimientoEmprendedorApiClient;

  @GET("/emprendedor/emprendimiento/usuario/{idUsuario}")
  Future<EmprendimientoEmprendedorResponse> getEmprendimientoByIdUsuario(
      @Path("idUsuario") int idUsuario,
      );

  @PUT("/emprendedor/emprendimiento/{idEmprendimiento}")
  Future<EmprendimientoEmprendedorResponse> updateEmprendimiento(
      @Path("idEmprendimiento") int idEmprendimiento,
      @Part(name: "emprendimiento") String emprendimientoJson,
      @Part(name: "file") MultipartFile? file,
      );
}