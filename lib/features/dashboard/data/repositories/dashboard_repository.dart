import 'package:dio/dio.dart';

import '../../../../core/api/api_result.dart';
import '../datasource/dashboard_remote_datasource.dart';
import '../models/dashboard_model.dart';

class DashboardRepository {
  DashboardRepository({
    required DashboardRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final DashboardRemoteDataSource _remoteDataSource;

  Future<ApiResult<DashboardModel>> getDashboard() async {
    try {
      final dashboard = await _remoteDataSource.getDashboard();

      return ApiResult.success(
        dashboard,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return const ApiResult.failure(
          'Koneksi ke server timeout.',
        );
      }

      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        return ApiResult.failure(
          data['message'] ?? 'Gagal memuat dashboard.',
        );
      }

      return const ApiResult.failure(
        'Gagal memuat dashboard.',
      );
    } catch (_) {
      return const ApiResult.failure(
        'Gagal memuat dashboard.',
      );
    }
  }
}
