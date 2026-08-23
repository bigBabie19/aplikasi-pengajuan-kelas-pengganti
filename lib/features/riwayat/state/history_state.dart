import '../data/models/history_submission_model.dart';
import '../data/models/history_detail_model.dart';

class HistoryState {
  final bool isLoading;
  final bool isDetailLoading;

  final List<HistorySubmissionModel> submissions;
  final HistoryDetailModel? detail;

  final String? error;
  final String? detailError;

  const HistoryState({
    this.isLoading = false,
    this.isDetailLoading = false,
    this.submissions = const [],
    this.detail,
    this.error,
    this.detailError,
  });

  HistoryState copyWith({
    bool? isLoading,
    bool? isDetailLoading,
    List<HistorySubmissionModel>? submissions,
    HistoryDetailModel? detail,
    String? error,
    String? detailError,
    bool clearDetail = false,
    bool clearError = false,
    bool clearDetailError = false,
  }) {
    return HistoryState(
      isLoading: isLoading ?? this.isLoading,
      isDetailLoading: isDetailLoading ?? this.isDetailLoading,
      submissions: submissions ?? this.submissions,
      detail: clearDetail ? null : detail ?? this.detail,
      error: clearError ? null : error ?? this.error,
      detailError: clearDetailError ? null : detailError ?? this.detailError,
    );
  }
}
