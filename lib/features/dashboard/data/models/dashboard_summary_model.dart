class DashboardSummaryModel {
  final int total;
  final int pending;
  final int approved;
  final int rejected;

  const DashboardSummaryModel({
    required this.total,
    required this.pending,
    required this.approved,
    required this.rejected,
  });

  factory DashboardSummaryModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return DashboardSummaryModel(
      total: json['total'] ?? 0,
      pending: json['pending'] ?? 0,
      approved: json['approved'] ?? 0,
      rejected: json['rejected'] ?? 0,
    );
  }
}
