import 'dart:io';

import 'package:dio/dio.dart';

import '../models/course_model.dart';
import '../models/pengajuan_request_model.dart';
import '../models/room_model.dart';
import '../models/schedule_model.dart';
import '../../../../core/api/api_client.dart';

class PengajuanRemoteDatasource {
  PengajuanRemoteDatasource();

  final Dio _dio = ApiClient.dio;

  Future<List<CourseModel>> getCourses({
    String? search,
  }) async {
    final response = await _dio.get(
      '/pengajuan/courses',
      queryParameters: {
        if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
      },
    );

    final List<dynamic> data = response.data['data'];

    return data
        .map(
          (json) => CourseModel.fromJson(
            json as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<List<ScheduleModel>> getSchedules({
    required int courseId,
  }) async {
    final response = await _dio.get(
      '/pengajuan/schedules',
      queryParameters: {
        'course_id': courseId,
      },
    );

    final List<dynamic> data = response.data['data'];

    return data
        .map(
          (json) => ScheduleModel.fromJson(
            json as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<List<RoomModel>> getAvailableRooms({
    required int scheduleId,
    required DateTime replacementDate,
    required String startTime,
  }) async {
    final response = await _dio.get(
      '/pengajuan/available-rooms',
      queryParameters: {
        'jadwal_id': scheduleId,
        'tanggal_kelas_pengganti': _formatDate(replacementDate),
        'jam_mulai': startTime,
      },
    );

    final List<dynamic> data = response.data['data'];

    return data
        .map(
          (json) => RoomModel.fromJson(
            json as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<void> submitPengajuan(
    PengajuanRequestModel request,
  ) async {
    final formData = FormData.fromMap({
      'jadwal_id': request.scheduleId,
      'ruangan_id': request.roomId,
      'tanggal_kelas_asal': _formatDate(request.originalDate),
      'tanggal_kelas_pengganti': _formatDate(
        request.replacementDate,
      ),
      'jam_mulai': request.startTime,
      'alasan': request.reason,
      if (request.attachmentPath != null)
        'lampiran': await MultipartFile.fromFile(
          request.attachmentPath!,
          filename: File(request.attachmentPath!).uri.pathSegments.last,
        ),
    });

    await _dio.post(
      '/pengajuan',
      data: formData,
    );
  }

  String _formatDate(DateTime date) {
    return date.toIso8601String().split('T').first;
  }
}
