import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'file_api_client.g.dart';

@RestApi()
abstract class FileApiClient {
  factory FileApiClient(Dio dio, {String baseUrl}) = _FileApiClient;

  @GET("/filePerfil/file/{fileName}")
  @DioResponseType(ResponseType.bytes)
  Future<HttpResponse<List<int>>> downloadFile(@Path("fileName") String fileName);
}