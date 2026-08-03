class PengajuanRequestModel {
  final int scheduleId;
  final int roomId;
  final DateTime originalDate;
  final DateTime replacementDate;
  final String startTime;
  final String reason;
  final String? attachmentPath;

  const PengajuanRequestModel({
    required this.scheduleId,
    required this.roomId,
    required this.originalDate,
    required this.replacementDate,
    required this.startTime,
    required this.reason,
    this.attachmentPath,
  });
}
