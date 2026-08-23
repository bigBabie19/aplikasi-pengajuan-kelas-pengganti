import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/history_repository.dart';
import '../state/history_state.dart';

class HistoryNotifier extends StateNotifier<HistoryState> {
  HistoryNotifier(this._repository) : super(const HistoryState());

  final HistoryRepository _repository;

  bool _loaded = false;

  Future<void> loadHistory({
    bool forceRefresh = false,
  }) async {
    if (_loaded && !forceRefresh && state.submissions.isNotEmpty) {
      return;
    }

    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    final result = await _repository.getHistory();

    if (!result.isSuccess) {
      state = state.copyWith(
        isLoading: false,
        error: result.error,
      );
      return;
    }

    _loaded = true;

    state = state.copyWith(
      isLoading: false,
      submissions: result.data!,
      clearError: true,
    );
  }

  Future<void> loadDetail(int id) async {
    state = state.copyWith(
      isDetailLoading: true,
      clearDetailError: true,
    );

    final result = await _repository.getDetail(id);

    if (!result.isSuccess) {
      state = state.copyWith(
        isDetailLoading: false,
        detailError: result.error,
      );
      return;
    }

    state = state.copyWith(
      isDetailLoading: false,
      detail: result.data,
      clearDetailError: true,
    );
  }
}
