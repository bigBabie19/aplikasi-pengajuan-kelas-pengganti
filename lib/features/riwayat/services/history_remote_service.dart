import '../../../../core/api/api_client.dart';
import '../models/history_detail_model.dart';

class HistoryRemoteService {
  const HistoryRemoteService();

  Future<HistoryDetailModel> getDetail(
    int id,
  ) async {
    final response = await ApiClient.dio.get(
      '/pengajuan/$id',
    );

    return HistoryDetailModel.fromJson(
      response.data['data'],
    );
  }
}
