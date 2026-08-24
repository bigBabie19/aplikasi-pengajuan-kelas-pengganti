import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../providers/pengajuan_provider.dart';
import 'form_section.dart';

class AttachmentPicker extends ConsumerWidget {
  const AttachmentPicker({
    super.key,
  });

  Future<void> _pickFile(
    WidgetRef ref,
  ) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const [
        'pdf',
        'jpg',
        'jpeg',
        'png',
      ],
    );

    if (result == null) {
      return;
    }
    

    final filePath = result.files.single.path;

    debugPrint('=== ATTACHMENT PICKER ===');
    debugPrint('name: ${result.files.single.name}');
    debugPrint('path: $filePath');
    debugPrint('size: ${result.files.single.size}');

    ref
        .read(
          pengajuanFormViewModelProvider.notifier,
        )
        .setAttachment(filePath);
  }

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final state = ref.watch(
      pengajuanFormViewModelProvider,
    );

    return FormSection(
      title: 'Lampiran',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppColors.border,
                disabledForegroundColor: AppColors.subtitle,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: state.isBusy ? null : () => _pickFile(ref),
              icon: const Icon(
                Icons.upload_file_rounded,
              ),
              label: Text(
                state.attachmentName == null ? 'Pilih File' : 'Ganti File',
                style: AppTextStyle.body.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.card,
              border: Border.all(
                color: AppColors.border,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  state.attachmentName == null
                      ? Icons.insert_drive_file_outlined
                      : Icons.description_rounded,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    state.attachmentName ?? 'Belum ada file dipilih',
                    style: AppTextStyle.body.copyWith(
                      color: state.attachmentName == null
                          ? AppColors.subtitle
                          : AppColors.text,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Format: PDF, JPG, JPEG, PNG (maks. 5 MB)',
            style: AppTextStyle.caption.copyWith(
              color: AppColors.subtitle,
            ),
          ),
        ],
      ),
    );
  }
}
