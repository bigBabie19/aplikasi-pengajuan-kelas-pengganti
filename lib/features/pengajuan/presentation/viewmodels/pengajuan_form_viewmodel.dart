import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/course.dart';
import '../../domain/entities/room.dart';
import '../../domain/entities/schedule.dart';
import '../../domain/repositories/pengajuan_repository.dart';
import '../providers/pengajuan_provider.dart';
import '../state/pengajuan_form_state.dart';
import '../state/form_status.dart';
import '../state/ui_message.dart';
import 'package:path/path.dart' as path;

class PengajuanFormViewModel extends Notifier<PengajuanFormState> {
  late final PengajuanRepository _repository;

  @override
  PengajuanFormState build() {
    _repository = ref.read(
      pengajuanRepositoryProvider,
    );

    return const PengajuanFormState();
  }

  Future<void> loadCourses() async {
    state = state.copyWith(
      courseStatus: FormStatus.loading,
    );

    try {
      final courses = await _repository.getCourses();

      state = state.copyWith(
        courseStatus: FormStatus.success,
        courses: courses,
      );
    } catch (e) {
      state = state.copyWith(
        courseStatus: FormStatus.error,
        message: UiMessage.error(e.toString()),
      );
    }
  }

  Future<void> selectCourse(Course course) async {
    state = state.copyWith(
      selectedCourse: course,
      selectedSchedule: null,
      selectedRoom: null,
      schedules: const [],
      rooms: const [],
      originalDate: null,
      replacementDate: null,
      startTime: null,
      reason: '',
      attachmentPath: null,
      attachmentName: null,
    );

    await loadSchedules(course.id);
  }

  Future<void> loadSchedules(int courseId) async {
    state = state.copyWith(
      scheduleStatus: FormStatus.loading,
      message: null,
    );

    try {
      final schedules = await _repository.getSchedules(
        courseId: courseId,
      );

      state = state.copyWith(
        scheduleStatus: FormStatus.success,
        schedules: schedules,
      );
    } catch (e) {
      state = state.copyWith(
        scheduleStatus: FormStatus.error,
        message: UiMessage.error(e.toString()),
      );
    }
  }

  void selectSchedule(Schedule schedule) {
    state = state.copyWith(
      selectedSchedule: schedule,
      originalDate: null,
      replacementDate: null,
      startTime: null,
      selectedRoom: null,
      rooms: const [],
      roomStatus: FormStatus.initial,
    );
  }

  void setOriginalDate(DateTime date) {
    state = state.copyWith(
      originalDate: date,
      replacementDate: null,
      startTime: null,
      selectedRoom: null,
      rooms: const [],
      roomStatus: FormStatus.initial,
    );
  }

  Future<void> setReplacementDate(DateTime date) async {
    state = state.copyWith(
      replacementDate: date,
      selectedRoom: null,
      rooms: const [],
      roomStatus: FormStatus.initial,
    );

    if (state.startTime != null) {
      await loadAvailableRooms();
    }
  }

  Future<void> setStartTime(String startTime) async {
    state = state.copyWith(
      startTime: startTime,
      selectedRoom: null,
      rooms: const [],
      roomStatus: FormStatus.initial,
    );

    if (state.replacementDate != null) {
      await loadAvailableRooms();
    }
  }

  Future<void> loadAvailableRooms() async {
    final schedule = state.selectedSchedule;
    final replacementDate = state.replacementDate;
    final startTime = state.startTime;

    if (schedule == null || replacementDate == null || startTime == null) {
      return;
    }

    state = state.copyWith(
      roomStatus: FormStatus.loading,
      selectedRoom: null,
      message: null,
    );

    try {
      final rooms = await _repository.getAvailableRooms(
        scheduleId: schedule.id,
        replacementDate: replacementDate,
        startTime: startTime,
      );

      state = state.copyWith(
        roomStatus: FormStatus.success,
        rooms: rooms,
      );
    } catch (e) {
      state = state.copyWith(
        roomStatus: FormStatus.error,
        message: UiMessage.error(e.toString()),
      );
    }
  }

  void selectRoom(Room room) {
    state = state.copyWith(
      selectedRoom: room,
    );
  }

  void setReason(String reason) {
    state = state.copyWith(
      reason: reason.trimLeft(),
    );
  }

  void setAttachment(String? filePath) {
    if (filePath == null) {
      state = state.copyWith(
        attachmentPath: null,
        attachmentName: null,
      );
      return;
    }

    state = state.copyWith(
      attachmentPath: filePath,
      attachmentName: path.basename(filePath),
    );
  }

  Future<void> submit() async {
    final schedule = state.selectedSchedule;
    final room = state.selectedRoom;
    final originalDate = state.originalDate;
    final replacementDate = state.replacementDate;
    final startTime = state.startTime;

    if (schedule == null) {
      state = state.copyWith(
        submitStatus: FormStatus.error,
        message: const UiMessage.error(
          'Silakan pilih jadwal.',
        ),
      );
      return;
    }

    if (originalDate == null) {
      state = state.copyWith(
        submitStatus: FormStatus.error,
        message: const UiMessage.error(
          'Silakan pilih tanggal kelas asal.',
        ),
      );
      return;
    }

    if (replacementDate == null) {
      state = state.copyWith(
        submitStatus: FormStatus.error,
        message: const UiMessage.error(
          'Silakan pilih tanggal kelas pengganti.',
        ),
      );
      return;
    }

    if (startTime == null) {
      state = state.copyWith(
        submitStatus: FormStatus.error,
        message: const UiMessage.error(
          'Silakan pilih jam mulai.',
        ),
      );
      return;
    }

    if (room == null) {
      state = state.copyWith(
        submitStatus: FormStatus.error,
        message: const UiMessage.error(
          'Silakan pilih ruangan.',
        ),
      );
      return;
    }

    if (state.reason.trim().isEmpty) {
      state = state.copyWith(
        submitStatus: FormStatus.error,
        message: const UiMessage.error(
          'Alasan pengajuan wajib diisi.',
        ),
      );
      return;
    }

    state = state.copyWith(
      submitStatus: FormStatus.loading,
      message: null,
    );

    try {
      await _repository.submitPengajuan(
        scheduleId: schedule.id,
        roomId: room.id,
        originalDate: originalDate,
        replacementDate: replacementDate,
        startTime: startTime,
        reason: state.reason,
        attachmentPath: state.attachmentPath,
      );

      state = state.copyWith(
        submitStatus: FormStatus.success,
        message: const UiMessage.success(
          'Pengajuan berhasil dikirim.',
        ),
      );
    } catch (e) {
      state = state.copyWith(
        submitStatus: FormStatus.error,
        message: UiMessage.error(
          e.toString(),
        ),
      );
    }
  }

  void reset() {
    state = const PengajuanFormState();
  }

  void clearMessage() {
    state = state.copyWith(
      message: null,
    );
  }
}
