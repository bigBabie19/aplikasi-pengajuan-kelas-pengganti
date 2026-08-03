import 'package:flutter/material.dart';

import '../../../../core/widgets/app_picker_field.dart';

class TimeField extends StatelessWidget {
  const TimeField({
    super.key,
    this.value = '',
    this.onTap,
  });

  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppPickerField(
      label: 'Jam',
      value: value,
      icon: Icons.access_time_rounded,
      onTap: onTap ?? () {},
    );
  }
}
