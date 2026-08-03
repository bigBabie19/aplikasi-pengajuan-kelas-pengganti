class TodayScheduleModel {
  final String courseName;
  final String room;
  final String startTime;
  final String endTime;

  const TodayScheduleModel({
    required this.courseName,
    required this.room,
    required this.startTime,
    required this.endTime,
  });

  factory TodayScheduleModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TodayScheduleModel(
      courseName: json['course_name'],
      room: json['room'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }
}
