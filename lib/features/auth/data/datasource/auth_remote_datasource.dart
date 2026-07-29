import 'package:dio/dio.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoint.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource();

  final Dio _dio = ApiClient.dio;

  Future<LoginResponse> login(
    LoginRequest request,
  ) async {
    final response = await _dio.post(
      ApiEndpoint.login,
      data: request.toJson(),
    );

    return LoginResponse.fromJson(
      response.data,
    );
  }

  Future<UserModel> me() async {
    final response = await _dio.get(
      ApiEndpoint.me,
    );

    return UserModel.fromJson(
      response.data['data'],
    );
  }

  Future<void> logout() async {
    await _dio.post(
      ApiEndpoint.logout,
    );
  }
}
