import 'package:flutter/material.dart';

class RecentSubmissionEmpty extends StatelessWidget {
  const RecentSubmissionEmpty({
    super.key,
  });

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
            'Pengajuan kelas pengganti yang kamu buat akan muncul di sini.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
