import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
            children: [
              TextSpan(
                text: 'Butuh bantuan? Silakan hubungi ',
              ),
              TextSpan(
                text: 'Bagian Akademik',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        const Text(
          'Versi 1.0.0',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Dot(
              active: true,
            ),
            SizedBox(width: 4),
            _Dot(),
            SizedBox(width: 4),
            _Dot(),
          ],
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    this.active = false,
  });

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: active ? 7 : 5,
      height: active ? 7 : 5,
    );
  }
}
