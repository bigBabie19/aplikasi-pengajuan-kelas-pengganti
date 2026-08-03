import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class PengajuanAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PengajuanAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      title: Text(
        'Kelas Pengganti',
        style: AppTextStyle.heading.copyWith(
          fontSize: 20,
          color: AppColors.text,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_none_rounded,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            right: 16,
            left: 4,
          ),
          child: CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage(
              'assets/images/avatar_placeholder.png',
            ),
          ),
        ),
      ],
      iconTheme: const IconThemeData(
        color: AppColors.primary,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
