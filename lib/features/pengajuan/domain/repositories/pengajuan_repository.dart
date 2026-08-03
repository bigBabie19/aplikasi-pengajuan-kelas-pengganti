import '../entities/course.dart';
import '../entities/room.dart';
import '../entities/schedule.dart';

abstract interface class PengajuanRepository {
  Future<List<Course>> getCourses({
    String? search,
  });

  Future<List<Schedule>> getSchedules({
    required int courseId,
  });

  Future<List<Room>> getAvailableRooms({
    required int scheduleId,
    required DateTime replacementDate,
    required String startTime,
  });

  Future<void> submitPengajuan({
    required int scheduleId,
    required int roomId,
    required DateTime originalDate,
    required DateTime replacementDate,
    required String startTime,
    required String reason,
    String? attachmentPath,
  });
}
