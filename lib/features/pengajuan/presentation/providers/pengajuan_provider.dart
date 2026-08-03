import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/pengajuan_remote_datasource.dart';
import '../../data/repositories/pengajuan_repository_impl.dart';
import '../../domain/repositories/pengajuan_repository.dart';
import '../state/pengajuan_form_state.dart';
import '../viewmodels/pengajuan_form_viewmodel.dart';

final pengajuanRemoteDatasourceProvider =
    Provider<PengajuanRemoteDatasource>((ref) {
  return PengajuanRemoteDatasource();
});

final pengajuanRepositoryProvider = Provider<PengajuanRepository>((ref) {
  return PengajuanRepositoryImpl(
    ref.read(
      pengajuanRemoteDatasourceProvider,
    ),
  );
});

final pengajuanFormViewModelProvider =
    NotifierProvider<PengajuanFormViewModel, PengajuanFormState>(
  PengajuanFormViewModel.new,
);
