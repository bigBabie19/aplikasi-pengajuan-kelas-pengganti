import 'package:flutter/material.dart';

import '../../../../core/widgets/app_dropdown_field.dart';

class ClassDropdownField extends StatelessWidget {
  const ClassDropdownField({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDropdownField<String>(
      label: 'Kelas',
      hint: 'Pilih Kelas',
      value: null,
      items: const [],
      onChanged: (_) {},
    );
  }
}
