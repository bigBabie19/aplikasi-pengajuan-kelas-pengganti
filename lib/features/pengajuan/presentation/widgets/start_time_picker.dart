import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/pengajuan_provider.dart';
import 'form_section.dart';

class StartTimePicker extends ConsumerWidget {
  const StartTimePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      pengajuanFormViewModelProvider,
    );

    final viewModel = ref.read(
      pengajuanFormViewModelProvider.notifier,
    );

    final enabled =
        state.selectedSchedule != null && state.replacementDate != null;

    return FormSection(
      title: 'Jam Mulai',
      child: InkWell(
        borderRadius: BorderRadius.circular(
          12,
        ),
        onTap: !enabled
            ? null
            : () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (picked == null) return;

                final hour = picked.hour.toString().padLeft(2, '0');

                final minute = picked.minute.toString().padLeft(2, '0');

                await viewModel.setStartTime(
                  '$hour:$minute',
                );
              },
        child: InputDecorator(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Pilih jam',
            suffixIcon: Icon(
              Icons.schedule,
            ),
          ),
          child: Text(
            state.startTime ?? 'Belum dipilih',
          ),
        ),
      ),
    );
  }
}
