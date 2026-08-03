import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/pengajuan_provider.dart';
import 'form_section.dart';

class ReasonField extends ConsumerStatefulWidget {
  const ReasonField({
    super.key,
  });

  @override
  ConsumerState<ReasonField> createState() => _ReasonFieldState();
}

class _ReasonFieldState extends ConsumerState<ReasonField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    final state = ref.read(
      pengajuanFormViewModelProvider,
    );

    _controller = TextEditingController(
      text: state.reason,
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      pengajuanFormViewModelProvider,
    );

    final viewModel = ref.read(
      pengajuanFormViewModelProvider.notifier,
    );

    return FormSection(
      title: 'Alasan Pengajuan',
      child: TextFormField(
        controller: _controller,
        enabled: !state.isBusy,
        minLines: 4,
        maxLines: 6,
        maxLength: 500,
        textInputAction: TextInputAction.newline,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText:
              'Contoh:\nDosen berhalangan hadir karena mengikuti seminar nasional.',
          alignLabelWithHint: true,
        ),
        onChanged: viewModel.setReason,
      ),
    );
  }
}
