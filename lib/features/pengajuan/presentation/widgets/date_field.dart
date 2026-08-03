import 'package:flutter/material.dart';

import '../../../../core/widgets/app_picker_field.dart';

class DateField extends StatelessWidget {
  const DateField({
    super.key,
    this.value = '',
    this.onTap,
  });

  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppPickerField(
      label: 'Tanggal',
      value: value,
      icon: Icons.calendar_month_outlined,
      onTap: onTap ?? () {},
    );
  }
}
