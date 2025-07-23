import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'file_admin_api_client.g.dart';

@RestApi()
abstract class FileAdminApiClient {
  factory FileAdminApiClient(Dio dio, {String baseUrl}) = _FileAdminApiClient;

  @POST("/admin/file/upload")
  @MultiPart()
  Future<String> uploadFile(
      @Part(name: "file") MultipartFile? file,
      @Part(name: "tipo") String tipo,
      );

  @GET("/admin/file/{tipo}/{filename}")
  @DioResponseType(ResponseType.bytes) // para obtener el archivo como bytes
  Future<Uint8List> downloadFile(
      @Path("tipo") String tipo,
      @Path("filename") String filename,
      );
}