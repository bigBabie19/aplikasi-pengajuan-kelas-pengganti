class HistoryDetailModel {
  final int id;
  final String status;
  final String originalDate;
  final String replacementDate;
  final String startTime;
  final String endTime;
  final String reason;
  final String? adminNote;
  final String? processedAt;
  final String courseClass;
  final String room;
  final String processedBy;
  final String submitter;

  const HistoryDetailModel({
    required this.id,
    required this.status,
    required this.originalDate,
    required this.replacementDate,
    required this.startTime,
    required this.endTime,
    required this.reason,
    required this.adminNote,
    required this.processedAt,
    required this.courseClass,
    required this.room,
    required this.processedBy,
    required this.submitter,
  });

  factory HistoryDetailModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return HistoryDetailModel(
      id: json['id'] ?? 0,
      status: json['status'] ?? '-',
      originalDate: json['tanggal_kelas_asal'] ?? '-',
      replacementDate: json['tanggal_kelas_pengganti'] ?? '-',
      startTime: json['jam_mulai'] ?? '-',
      endTime: json['jam_selesai'] ?? '-',
      reason: json['alasan'] ?? '-',
      adminNote: json['catatan_admin'],
      processedAt: json['processed_at'],
      courseClass: json['jadwal']?['kode_kelas'] ?? '-',
      room: json['ruangan']?['nama'] ?? '-',
      processedBy: json['processed_by']?['name'] ?? '-',
      submitter: json['user']?['name'] ?? '-',
    );
  }
}
