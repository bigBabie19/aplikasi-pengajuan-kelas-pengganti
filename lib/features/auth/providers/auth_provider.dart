import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasource/auth_remote_datasource.dart';
import '../data/repositories/auth_repository.dart';
import '../notifiers/auth_notifier.dart';
import '../state/auth_state.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
  ),
);

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(
    ref.read(authRepositoryProvider),
  ),
);
