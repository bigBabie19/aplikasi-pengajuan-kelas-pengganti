class RecentSubmissionModel {
  final int id;
  final String courseName;
  final String lecturer;
  final String room;
  final String day;
  final String date;
  final String time;
  final String status;
  final String? approvalReason;

  const RecentSubmissionModel({
    required this.id,
    required this.courseName,
    required this.lecturer,
    required this.room,
    required this.day,
    required this.date,
    required this.time,
    required this.status,
    this.approvalReason,
  });

  factory RecentSubmissionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return RecentSubmissionModel(
      id: json['id'],
      courseName: json['course_name'],
      lecturer: json['lecturer'],
      room: json['room'],
      day: json['day'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
      approvalReason: json['approval_reason'],
    );
  }
}
