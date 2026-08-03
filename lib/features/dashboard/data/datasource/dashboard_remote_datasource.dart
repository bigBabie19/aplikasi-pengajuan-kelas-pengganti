import 'package:dio/dio.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoint.dart';
import '../models/dashboard_model.dart';

class DashboardRemoteDataSource {
  DashboardRemoteDataSource();

  final Dio _dio = ApiClient.dio;

  Future<DashboardModel> getDashboard() async {
    final response = await _dio.get(
      ApiEndpoint.dashboard,
    );

    return DashboardModel.fromJson(
      response.data['data'],
    );
  }
}
