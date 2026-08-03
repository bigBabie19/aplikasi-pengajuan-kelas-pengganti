import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class TodayDateText extends StatefulWidget {
  const TodayDateText({
    super.key,
  });

  @override
  State<TodayDateText> createState() => _TodayDateTextState();
}

class _TodayDateTextState extends State<TodayDateText> {
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id').then((_) {
      if (!mounted) return;

      setState(() {
        _ready = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const SizedBox();
    }

    final now = DateTime.now();

    final text = DateFormat(
      'EEEE, d MMMM yyyy',
      'id',
    ).format(now);

    return Text(
      text,
      style: AppTextStyle.caption.copyWith(
        color: AppColors.subtitle,
      ),
    );
  }
}
