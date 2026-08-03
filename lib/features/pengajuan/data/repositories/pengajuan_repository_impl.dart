import '../../domain/entities/course.dart';
import '../../domain/entities/room.dart';
import '../../domain/entities/schedule.dart';
import '../../domain/repositories/pengajuan_repository.dart';

import '../datasource/pengajuan_remote_datasource.dart';
import '../models/pengajuan_request_model.dart';

class PengajuanRepositoryImpl implements PengajuanRepository {
  final PengajuanRemoteDatasource remoteDatasource;

  const PengajuanRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<Course>> getCourses({
    String? search,
  }) async {
    final models = await remoteDatasource.getCourses(
      search: search,
    );

    return models
        .map(
          (model) => Course(
            id: model.id,
            name: model.name,
          ),
        )
        .toList();
  }

  @override
  Future<List<Schedule>> getSchedules({
    required int courseId,
  }) async {
    final models = await remoteDatasource.getSchedules(
      courseId: courseId,
    );

    return models
        .map(
          (model) => Schedule(
            id: model.id,
            courseId: model.courseId,
            courseName: model.courseName,
            lecturerId: model.lecturerId,
            lecturerName: model.lecturerName,
            className: model.className,
            participants: model.participants,
            startTime: model.startTime,
            endTime: model.endTime,
          ),
        )
        .toList();
  }

  @override
  Future<List<Room>> getAvailableRooms({
    required int scheduleId,
    required DateTime replacementDate,
    required String startTime,
  }) async {
    final models = await remoteDatasource.getAvailableRooms(
      scheduleId: scheduleId,
      replacementDate: replacementDate,
      startTime: startTime,
    );

    return models
        .map(
          (model) => Room(
            id: model.id,
            name: model.name,
            capacity: model.capacity,
          ),
        )
        .toList();
  }

  @override
  Future<void> submitPengajuan({
    required int scheduleId,
    required int roomId,
    required DateTime originalDate,
    required DateTime replacementDate,
    required String startTime,
    required String reason,
    String? attachmentPath,
  }) async {
    final request = PengajuanRequestModel(
      scheduleId: scheduleId,
      roomId: roomId,
      originalDate: originalDate,
      replacementDate: replacementDate,
      startTime: startTime,
      reason: reason,
      attachmentPath: attachmentPath,
    );

    await remoteDatasource.submitPengajuan(request);
  }
}
