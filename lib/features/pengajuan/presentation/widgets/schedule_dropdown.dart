import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/schedule.dart';
import '../providers/pengajuan_provider.dart';
import '../state/form_status.dart';
import 'form_section.dart';

class ScheduleDropdown extends ConsumerWidget {
  const ScheduleDropdown({
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

    return FormSection(
      title: 'Jadwal',
      child: DropdownSearch<Schedule>(
        enabled: state.selectedCourse != null &&
            state.scheduleStatus != FormStatus.loading &&
            !state.isBusy,
        items: (_, __) => state.schedules,
        selectedItem: state.selectedSchedule,
        compareFn: (a, b) => a.id == b.id,
        itemAsString: (schedule) {
          return '${schedule.className} • '
              '${schedule.day}, '
              '${schedule.startTime}-${schedule.endTime}';
        },
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            hintText: state.scheduleStatus == FormStatus.loading
                ? 'Memuat jadwal...'
                : state.selectedCourse == null
                    ? 'Pilih mata kuliah terlebih dahulu'
                    : state.schedules.isEmpty
                        ? 'Tidak ada jadwal'
                        : 'Pilih Jadwal',
            border: const OutlineInputBorder(),
            suffixIcon: state.scheduleStatus == FormStatus.loading
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : const Icon(Icons.schedule),
          ),
        ),
        popupProps: const PopupProps.menu(
          fit: FlexFit.loose,
        ),
        onChanged: (schedule) {
          if (schedule == null) return;

          viewModel.selectSchedule(schedule);
        },
      ),
    );
  }
}
