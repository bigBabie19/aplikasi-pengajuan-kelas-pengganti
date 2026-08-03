import '../../domain/entities/course.dart';
import '../../domain/entities/room.dart';
import '../../domain/entities/schedule.dart';
import 'form_status.dart';
import 'ui_message.dart';

class PengajuanFormState {
  static const _unset = Object();

  final FormStatus courseStatus;
  final FormStatus scheduleStatus;
  final FormStatus roomStatus;
  final FormStatus submitStatus;

  final List<Course> courses;
  final List<Schedule> schedules;
  final List<Room> rooms;

  final Course? selectedCourse;
  final Schedule? selectedSchedule;
  final Room? selectedRoom;

  final DateTime? originalDate;
  final DateTime? replacementDate;

  final String? startTime;

  final String reason;

  final String? attachmentPath;
  final String? attachmentName;

  final UiMessage? message;

  const PengajuanFormState({
    this.courseStatus = FormStatus.initial,
    this.scheduleStatus = FormStatus.initial,
    this.roomStatus = FormStatus.initial,
    this.submitStatus = FormStatus.initial,
    this.courses = const [],
    this.schedules = const [],
    this.rooms = const [],
    this.selectedCourse,
    this.selectedSchedule,
    this.selectedRoom,
    this.originalDate,
    this.replacementDate,
    this.startTime,
    this.reason = '',
    this.attachmentPath,
    this.attachmentName,
    this.message,
  });

  PengajuanFormState copyWith({
    FormStatus? courseStatus,
    FormStatus? scheduleStatus,
    FormStatus? roomStatus,
    FormStatus? submitStatus,
    List<Course>? courses,
    List<Schedule>? schedules,
    List<Room>? rooms,
    Object? selectedCourse = _unset,
    Object? selectedSchedule = _unset,
    Object? selectedRoom = _unset,
    Object? originalDate = _unset,
    Object? replacementDate = _unset,
    Object? startTime = _unset,
    String? reason,
    Object? attachmentPath = _unset,
    Object? attachmentName = _unset,
    Object? message = _unset,
  }) {
    return PengajuanFormState(
      courseStatus: courseStatus ?? this.courseStatus,
      scheduleStatus: scheduleStatus ?? this.scheduleStatus,
      roomStatus: roomStatus ?? this.roomStatus,
      submitStatus: submitStatus ?? this.submitStatus,
      courses: courses ?? this.courses,
      schedules: schedules ?? this.schedules,
      rooms: rooms ?? this.rooms,
      selectedCourse: identical(selectedCourse, _unset)
          ? this.selectedCourse
          : selectedCourse as Course?,
      selectedSchedule: identical(selectedSchedule, _unset)
          ? this.selectedSchedule
          : selectedSchedule as Schedule?,
      selectedRoom: identical(selectedRoom, _unset)
          ? this.selectedRoom
          : selectedRoom as Room?,
      originalDate: identical(originalDate, _unset)
          ? this.originalDate
          : originalDate as DateTime?,
      replacementDate: identical(replacementDate, _unset)
          ? this.replacementDate
          : replacementDate as DateTime?,
      startTime:
          identical(startTime, _unset) ? this.startTime : startTime as String?,
      reason: reason ?? this.reason,
      attachmentPath: identical(attachmentPath, _unset)
          ? this.attachmentPath
          : attachmentPath as String?,
      attachmentName: identical(attachmentName, _unset)
          ? this.attachmentName
          : attachmentName as String?,
      message:
          identical(message, _unset) ? this.message : message as UiMessage?,
    );
  }

  bool get isBusy =>
      courseStatus == FormStatus.loading ||
      scheduleStatus == FormStatus.loading ||
      roomStatus == FormStatus.loading ||
      submitStatus == FormStatus.loading;
}
