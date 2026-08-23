class HistorySubmissionModel {
  final int id;
  final String status;
  final String originalDate;
  final String replacementDate;
  final String startTime;
  final String endTime;
  final String reason;
  final String? adminNote;
  final String? processedAt;
  final String submitter;
  final String courseClass;
  final String room;

  const HistorySubmissionModel({
    required this.id,
    required this.status,
    required this.originalDate,
    required this.replacementDate,
    required this.startTime,
    required this.endTime,
    required this.reason,
    required this.adminNote,
    required this.processedAt,
    required this.submitter,
    required this.courseClass,
    required this.room,
  });

  factory HistorySubmissionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final user = json['user'] as Map<String, dynamic>?;
    final jadwal = json['jadwal'] as Map<String, dynamic>?;
    final ruangan = json['ruangan'] as Map<String, dynamic>?;

    return HistorySubmissionModel(
      id: json['id'] ?? 0,
      status: json['status'] ?? '-',
      originalDate: json['tanggal_kelas_asal'] ?? '-',
      replacementDate: json['tanggal_kelas_pengganti'] ?? '-',
      startTime: json['jam_mulai'] ?? '-',
      endTime: json['jam_selesai'] ?? '-',
      reason: json['alasan'] ?? '-',
      adminNote: json['catatan_admin'],
      processedAt: json['processed_at'],
      submitter: user?['name'] ?? '-',
      courseClass: jadwal?['kode_kelas'] ?? '-',
      room: ruangan?['nama'] ?? '-',
    );
  }
}
