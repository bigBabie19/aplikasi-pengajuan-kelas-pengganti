class Schedule {
  final int id;
  final int courseId;
  final String courseName;
  final int lecturerId;
  final String lecturerName;
  final String className;
  final int participants;
  final String day;
  final String startTime;
  final String endTime;

  const Schedule({
    required this.id,
    required this.courseId,
    required this.courseName,
    required this.lecturerId,
    required this.lecturerName,
    required this.className,
    required this.participants,
    required this.day,
    required this.startTime,
    required this.endTime,
  });
}
