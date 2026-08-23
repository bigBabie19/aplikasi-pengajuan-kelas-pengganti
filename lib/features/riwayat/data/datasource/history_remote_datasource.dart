import 'package:dio/dio.dart';

import '../../../../core/api/api_client.dart';

import '../models/history_submission_model.dart';
import '../models/history_detail_model.dart';

class HistoryRemoteDataSource {
  HistoryRemoteDataSource();

  final Dio _dio = ApiClient.dio;

  Future<List<HistorySubmissionModel>> getHistory() async {
    final response = await _dio.get('/pengajuan');

    final data = response.data['data'] as List? ?? [];

    return data
        .map(
          (item) => HistorySubmissionModel.fromJson(
            item as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<HistoryDetailModel> getDetail(int id) async {
    final response = await _dio.get('/pengajuan/$id');

    return HistoryDetailModel.fromJson(
      response.data['data'],
    );
  }
}
