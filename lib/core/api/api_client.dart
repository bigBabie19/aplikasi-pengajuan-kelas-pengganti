import 'package:dio/dio.dart';

import '../constants/app_constants.dart';
import 'api_endpoint.dart';
import 'auth_interceptor.dart';

class ApiClient {
  ApiClient._();

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoint.baseUrl,
      connectTimeout: AppConstants.apiTimeout,
      receiveTimeout: AppConstants.apiTimeout,
      sendTimeout: AppConstants.apiTimeout,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  )
    ..interceptors.add(AuthInterceptor())
    ..interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
}
