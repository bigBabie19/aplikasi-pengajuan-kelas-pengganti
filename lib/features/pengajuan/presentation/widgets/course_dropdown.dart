import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/course.dart';
import '../providers/pengajuan_provider.dart';
import '../state/form_status.dart';
import 'form_section.dart';

class CourseDropdown extends ConsumerWidget {
  const CourseDropdown({
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
      title: 'Mata Kuliah',
      child: DropdownSearch<Course>(
        enabled: state.courseStatus != FormStatus.loading && !state.isBusy,
        items: (filter, _) {
          if (filter.isEmpty) {
            return state.courses;
          }

          return state.courses.where((course) {
            return course.name.toLowerCase().contains(
                  filter.toLowerCase(),
                );
          }).toList();
        },
        selectedItem: state.selectedCourse,
        compareFn: (a, b) => a.id == b.id,
        itemAsString: (course) => course.name,
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            hintText: state.courseStatus == FormStatus.loading
                ? 'Memuat mata kuliah...'
                : state.courses.isEmpty
                    ? 'Tidak ada mata kuliah'
                    : 'Pilih Mata Kuliah',
            border: const OutlineInputBorder(),
            suffixIcon: state.courseStatus == FormStatus.loading
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
                : const Icon(Icons.menu_book),
          ),
        ),
        popupProps: const PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: 'Cari Mata Kuliah...',
            ),
          ),
          fit: FlexFit.loose,
        ),
        onChanged: (course) {
          if (course == null) return;

          viewModel.selectCourse(course);
        },
      ),
    );
  }
}
