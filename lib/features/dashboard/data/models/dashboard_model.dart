import '../../../auth/data/models/user_model.dart';
import 'dashboard_summary_model.dart';
import 'recent_submission_model.dart';
import 'today_schedule_model.dart';

class DashboardModel {
  final UserModel user;
  final DashboardSummaryModel summary;
  final List<RecentSubmissionModel> recentSubmissions;
  final List<TodayScheduleModel> todaySchedules;

  const DashboardModel({
    required this.user,
    required this.summary,
    required this.recentSubmissions,
    required this.todaySchedules,
  });

  factory DashboardModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return DashboardModel(
      user: UserModel.fromJson(json['user']),
      summary: DashboardSummaryModel.fromJson(
        json['summary'],
      ),
      recentSubmissions: (json['recent_submissions'] as List? ?? [])
          .map(
            (e) => RecentSubmissionModel.fromJson(e),
          )
          .toList(),
      todaySchedules: (json['today_schedules'] as List? ?? [])
          .map(
            (e) => TodayScheduleModel.fromJson(e),
          )
          .toList(),
    );
  }
}
