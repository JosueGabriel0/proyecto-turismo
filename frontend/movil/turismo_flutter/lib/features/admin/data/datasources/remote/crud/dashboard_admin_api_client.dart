import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:turismo_flutter/features/admin/data/models/dashboard_admin_response.dart';

part 'dashboard_admin_api_client.g.dart';

@RestApi()
abstract class DashboardAdminApiClient {
  factory DashboardAdminApiClient(Dio dio, {String baseUrl}) = _DashboardAdminApiClient;

  @GET("/admin/dashboard")
  Future<DashboardAdminResponse> getDashboard();
}