import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/api/api_result.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../datasource/auth_remote_datasource.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/user_model.dart';

class AuthRepository {
  AuthRepository({
    required AuthRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final AuthRemoteDataSource _remoteDataSource;

  Future<ApiResult<LoginResponse>> login(
    LoginRequest request,
  ) async {
    try {
      final response = await _remoteDataSource.login(request);

      await SecureStorageService.instance.saveToken(response.token);

      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(
        _extractMessage(e),
      );
    } catch (_) {
      return const ApiResult.failure(
        'Terjadi kesalahan.',
      );
    }
  }

  Future<ApiResult<UserModel>> me() async {
    try {
      final user = await _remoteDataSource.me();

      return ApiResult.success(user);
    } on DioException catch (e) {
      return ApiResult.failure(
        _extractMessage(e),
      );
    } catch (_) {
      return const ApiResult.failure(
        'Terjadi kesalahan.',
      );
    }
  }

  Future<ApiResult<void>> logout() async {
    try {
      await _remoteDataSource.logout();

      await SecureStorageService.instance.clear();

      return const ApiResult.success(null);
    } on DioException catch (e) {
      debugPrint('========== DIO ERROR ==========');
      debugPrint('TYPE : ${e.type}');
      debugPrint('MESSAGE : ${e.message}');
      debugPrint('STATUS : ${e.response?.statusCode}');
      debugPrint('DATA : ${e.response?.data}');
      debugPrint('===============================');

      return ApiResult.failure(
        _extractMessage(e),
      );
    } catch (_) {
      return const ApiResult.failure(
        'Terjadi kesalahan.',
      );
    }
  }

  String _extractMessage(
    DioException e,
  ) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      return data['message'] ?? 'Terjadi kesalahan.';
    }

    return 'Terjadi kesalahan.';
  }
}
