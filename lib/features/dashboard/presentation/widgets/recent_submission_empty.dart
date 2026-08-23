import 'package:flutter/material.dart';

class RecentSubmissionEmpty extends StatelessWidget {
  const RecentSubmissionEmpty({
    super.key,
    this.isLecturer = false,
  });

  final bool isLecturer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 72,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 18),
          const Text(
            'Belum Ada Pengajuan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isLecturer
                ? 'Pengajuan kelas pengganti dari mahasiswa pada mata kuliah yang kamu ampu akan muncul di sini.'
                : 'Pengajuan kelas pengganti yang kamu buat akan muncul di sini.',
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
