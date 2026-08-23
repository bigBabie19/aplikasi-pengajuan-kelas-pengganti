import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/history_submission_model.dart';
import 'history_card.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({
    super.key,
    required this.submissions,
  });

  final List<HistorySubmissionModel> submissions;

  @override
  Widget build(BuildContext context) {
    if (submissions.isEmpty) {
      return ListView(
        children: const [
          SizedBox(height: 120),
          Center(
            child: Text(
              'Belum ada riwayat pengajuan.',
            ),
          ),
        ],
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: submissions.length,
      separatorBuilder: (_, __) => const SizedBox(
        height: 14,
      ),
      itemBuilder: (context, index) {
        final submission = submissions[index];

        return HistoryCard(
          submission: submission,
          onTap: () {
            context.pushNamed(
              'history-detail',
              pathParameters: {
                'id': submission.id.toString(),
              },
            );
          },
        );
      },
    );
  }
}
