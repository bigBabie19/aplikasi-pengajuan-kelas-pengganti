import 'package:dio/dio.dart';

import '../../../../core/api/api_result.dart';

import '../datasource/history_remote_datasource.dart';
import '../models/history_submission_model.dart';
import '../models/history_detail_model.dart';

class HistoryRepository {
  HistoryRepository({
    required HistoryRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final HistoryRemoteDataSource _remoteDataSource;

  Future<ApiResult<List<HistorySubmissionModel>>> getHistory() async {
    try {
      final history = await _remoteDataSource.getHistory();

      return ApiResult.success(history);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        return ApiResult.failure(
          data['message'] ?? 'Gagal memuat riwayat pengajuan.',
        );
      }

      return const ApiResult.failure(
        'Gagal memuat riwayat pengajuan.',
      );
    } catch (_) {
      return const ApiResult.failure(
        'Gagal memuat riwayat pengajuan.',
      );
    }
  }

  Future<ApiResult<HistoryDetailModel>> getDetail(
    int id,
  ) async {
    try {
      final detail = await _remoteDataSource.getDetail(id);

      return ApiResult.success(detail);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        return ApiResult.failure(
          data['message'] ?? 'Gagal memuat detail pengajuan.',
        );
      }

      return const ApiResult.failure(
        'Gagal memuat detail pengajuan.',
      );
    } catch (_) {
      return const ApiResult.failure(
        'Gagal memuat detail pengajuan.',
      );
    }
  }
}
