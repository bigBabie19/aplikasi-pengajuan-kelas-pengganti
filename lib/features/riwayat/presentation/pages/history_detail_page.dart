import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../models/history_detail_model.dart';
import '../../services/history_remote_service.dart';

class HistoryDetailPage extends StatefulWidget {
  const HistoryDetailPage({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  late Future<HistoryDetailModel> future;

  @override
  void initState() {
    super.initState();

    future = const HistoryRemoteService().getDetail(widget.id);
  }

  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return AppColors.success;

      case 'rejected':
        return AppColors.danger;

      default:
        return AppColors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        foregroundColor: AppColors.text,
        title: Text(
          'Detail Pengajuan',
          style: AppTextStyle.heading.copyWith(
            color: AppColors.text,
          ),
        ),
      ),
      body: FutureBuilder<HistoryDetailModel>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: AppColors.danger,
                    size: 50,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Gagal memuat detail pengajuan.',
                    style: AppTextStyle.body.copyWith(
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
            );
          }

          final item = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                elevation: 0,
                color: AppColors.card,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title('Status'),
                      const SizedBox(height: 8),
                      Chip(
                        side: BorderSide.none,
                        backgroundColor: statusColor(
                          item.status,
                        ).withOpacity(.12),
                        label: Text(
                          item.status.toUpperCase(),
                          style: AppTextStyle.caption.copyWith(
                            color: statusColor(item.status),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Divider(height: 36),
                      _title('Kelas'),
                      _value(item.courseClass),
                      const SizedBox(height: 18),
                      _title('Ruangan'),
                      _value(item.room),
                      const SizedBox(height: 18),
                      _title('Tanggal Kelas Asal'),
                      _value(item.originalDate),
                      const SizedBox(height: 18),
                      _title('Tanggal Pengganti'),
                      _value(item.replacementDate),
                      const SizedBox(height: 18),
                      _title('Jam'),
                      _value(
                        '${item.startTime} - ${item.endTime}',
                      ),
                      const SizedBox(height: 18),
                      _title('Alasan Pengajuan'),
                      _value(item.reason),
                      if (item.adminNote != null &&
                          item.adminNote!.trim().isNotEmpty) ...[
                        const Divider(height: 36),
                        _title('Catatan Admin'),
                        _value(item.adminNote!),
                      ],
                      const Divider(height: 36),
                      _title('Diproses Oleh'),
                      _value(item.processedBy),
                      const SizedBox(height: 18),
                      _title('Diproses Pada'),
                      _value(item.processedAt ?? '-'),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget _title(String text) {
  return Text(
    text,
    style: AppTextStyle.caption.copyWith(
      color: AppColors.subtitle,
    ),
  );
}

Widget _value(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 4),
    child: Text(
      text,
      style: AppTextStyle.body.copyWith(
        color: AppColors.text,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
