import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/room.dart';
import '../providers/pengajuan_provider.dart';
import '../state/form_status.dart';
import 'form_section.dart';

class RoomDropdown extends ConsumerWidget {
  const RoomDropdown({
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

    final enabled = state.selectedSchedule != null &&
        state.replacementDate != null &&
        state.startTime != null &&
        state.roomStatus != FormStatus.loading &&
        !state.isBusy;

    return FormSection(
      title: 'Ruangan',
      child: DropdownSearch<Room>(
        enabled: enabled,
        items: (_, __) => state.rooms,
        selectedItem: state.selectedRoom,
        compareFn: (a, b) => a.id == b.id,
        itemAsString: (room) => '${room.name} • Kapasitas ${room.capacity}',
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            hintText: state.roomStatus == FormStatus.loading
                ? 'Memuat ruangan...'
                : state.rooms.isEmpty
                    ? 'Tidak ada ruangan tersedia'
                    : 'Pilih Ruangan',
            border: const OutlineInputBorder(),
            suffixIcon: state.roomStatus == FormStatus.loading
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
                : const Icon(Icons.meeting_room),
          ),
        ),
        popupProps: const PopupProps.menu(
          showSearchBox: true,
          fit: FlexFit.loose,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: 'Cari Ruangan...',
            ),
          ),
        ),
        onChanged: (room) {
          if (room == null) return;

          viewModel.selectRoom(room);
        },
      ),
    );
  }
}
