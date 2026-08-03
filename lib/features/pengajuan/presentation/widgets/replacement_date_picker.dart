import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/pengajuan_provider.dart';
import 'form_section.dart';

class ReplacementDatePicker extends ConsumerWidget {
  const ReplacementDatePicker({
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
      title: 'Tanggal Pengganti',
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: !enabled
            ? null
            : () async {
                final minimumDate = state.originalDate ?? DateTime.now();

                final picked = await showDatePicker(
                  context: context,
                  initialDate: state.replacementDate ?? minimumDate,
                  firstDate: minimumDate,
                  lastDate: DateTime(
                    minimumDate.year + 1,
                  ),
                );

                if (picked == null) return;

                await viewModel.setReplacementDate(
                  picked,
                );
              },
        child: InputDecorator(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Pilih tanggal',
            suffixIcon: Icon(
              Icons.calendar_month,
            ),
          ),
          child: Text(
            state.replacementDate == null
                ? 'Belum dipilih'
                : DateFormat(
                    'EEEE, dd MMMM yyyy',
                    'id_ID',
                  ).format(
                    state.replacementDate!,
                  ),
          ),
        ),
      ),
    );
  }
}
