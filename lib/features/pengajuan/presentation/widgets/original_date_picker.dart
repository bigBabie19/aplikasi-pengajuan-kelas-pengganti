import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/pengajuan_provider.dart';
import 'form_section.dart';

class OriginalDatePicker extends ConsumerWidget {
  const OriginalDatePicker({
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

    final enabled = state.selectedSchedule != null;

    return FormSection(
      title: 'Tanggal Kelas Asal',
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: !enabled
            ? null
            : () async {
                final now = DateTime.now();

                final picked = await showDatePicker(
                  context: context,
                  initialDate: state.originalDate ?? now,
                  firstDate: DateTime(
                    now.year - 1,
                  ),
                  lastDate: DateTime(
                    now.year + 1,
                  ),
                );

                if (picked == null) return;

                viewModel.setOriginalDate(
                  picked,
                );
              },
        child: InputDecorator(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Pilih tanggal kelas asal',
            suffixIcon: Icon(
              Icons.event,
            ),
          ),
          child: Text(
            state.originalDate == null
                ? 'Belum dipilih'
                : DateFormat(
                    'EEEE, dd MMMM yyyy',
                    'id_ID',
                  ).format(
                    state.originalDate!,
                  ),
          ),
        ),
      ),
    );
  }
}
