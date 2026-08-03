class ScheduleModel {
  final int id;
  final int courseId;
  final String courseName;
  final int lecturerId;
  final String lecturerName;
  final String className;
  final int participants;
  final String startTime;
  final String endTime;

  const ScheduleModel({
    required this.id,
    required this.courseId,
    required this.courseName,
    required this.lecturerId,
    required this.lecturerName,
    required this.className,
    required this.participants,
    required this.startTime,
    required this.endTime,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'] as int,
      courseId: json['course_id'] as int,
      courseName: json['course_name'] as String,
      lecturerId: json['lecturer_id'] as int,
      lecturerName: json['lecturer_name'] as String,
      className: json['class_name'] as String,
      participants: json['participants'] as int,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_id': courseId,
      'course_name': courseName,
      'lecturer_id': lecturerId,
      'lecturer_name': lecturerName,
      'class_name': className,
      'participants': participants,
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}
