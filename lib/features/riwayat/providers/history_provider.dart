import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasource/history_remote_datasource.dart';
import '../data/repositories/history_repository.dart';

import '../notifiers/history_notifier.dart';
import '../state/history_state.dart';

final historyRemoteDataSourceProvider = Provider<HistoryRemoteDataSource>(
  (ref) => HistoryRemoteDataSource(),
);

final historyRepositoryProvider = Provider<HistoryRepository>(
  (ref) => HistoryRepository(
    remoteDataSource: ref.read(historyRemoteDataSourceProvider),
  ),
);

final historyNotifierProvider =
    StateNotifierProvider<HistoryNotifier, HistoryState>(
  (ref) => HistoryNotifier(
    ref.read(historyRepositoryProvider),
  ),
);
