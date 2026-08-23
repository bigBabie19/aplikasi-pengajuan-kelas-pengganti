import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/pengajuan_provider.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/course_dropdown.dart';
import '../widgets/schedule_dropdown.dart';
import '../widgets/replacement_date_picker.dart';
import '../widgets/start_time_picker.dart';
import '../widgets/reason_field.dart';
import '../widgets/room_dropdown.dart';
import '../widgets/attachment_picker.dart';
import '../widgets/submit_button.dart';
import '../widgets/original_date_picker.dart';
import '../../../dashboard/providers/dashboard_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class PengajuanPage extends ConsumerStatefulWidget {
  const PengajuanPage({
    super.key,
  });

  @override
  ConsumerState<PengajuanPage> createState() => _PengajuanPageState();
}

class _PengajuanPageState extends ConsumerState<PengajuanPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(
            pengajuanFormViewModelProvider.notifier,
          )
          .loadCourses();
    });
  }

  Future<void> _onSubmitRequested() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Konfirmasi Pengajuan',
            style: AppTextStyle.heading.copyWith(
              color: AppColors.primary,
            ),
          ),
          content: Text(
            'Apakah Anda yakin ingin mengirim pengajuan kelas pengganti?',
            style: AppTextStyle.body.copyWith(
              color: AppColors.text,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                'Batal',
                style: AppTextStyle.body.copyWith(
                  color: AppColors.subtitle,
                ),
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Kirim'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    await ref
        .read(
          pengajuanFormViewModelProvider.notifier,
        )
        .submit();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      pengajuanFormViewModelProvider,
      (_, next) async {
        final message = next.message;

        if (message == null) {
          return;
        }

        ref
            .read(
              pengajuanFormViewModelProvider.notifier,
            )
            .clearMessage();

        if (!mounted) {
          return;
        }

        if (message.isError) {
          await showDialog<void>(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: AppColors.card,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Text(
                  'Pengajuan Berhasil',
                  style: AppTextStyle.heading.copyWith(
                    color: AppColors.success,
                  ),
                ),
                content: Text(
                  message.message,
                  style: AppTextStyle.body.copyWith(
                    color: AppColors.text,
                  ),
                ),
                actions: [
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.success,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );

          return;
        }

        await showDialog<void>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Pengajuan Berhasil',
              ),
              content: Text(message.message),
              actions: [
                FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );

        if (!mounted) {
          return;
        }

        final vm = ref.read(
          pengajuanFormViewModelProvider.notifier,
        );

        vm.reset();

        await ref.read(dashboardNotifierProvider.notifier).loadDashboard(
              forceRefresh: true,
            );

        if (!mounted) {
          return;
        }

        Navigator.pop(context);
      },
    );

    final state = ref.watch(
      pengajuanFormViewModelProvider,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        title: Text(
          'Pengajuan Kelas Pengganti',
          style: AppTextStyle.heading.copyWith(
            color: AppColors.text,
          ),
        ),
      ),
      body: LoadingOverlay(
        isLoading: state.isBusy,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const CourseDropdown(),
                const SizedBox(height: 32),
                const ScheduleDropdown(),
                const SizedBox(height: 32),
                const OriginalDatePicker(),
                const SizedBox(height: 32),
                const ReplacementDatePicker(),
                const SizedBox(height: 32),
                const StartTimePicker(),
                const SizedBox(height: 32),
                const RoomDropdown(),
                const SizedBox(height: 32),
                const ReasonField(),
                const SizedBox(height: 32),
                const AttachmentPicker(),
                const SizedBox(height: 24),
                SubmitButton(
                  onSubmitRequested: _onSubmitRequested,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
