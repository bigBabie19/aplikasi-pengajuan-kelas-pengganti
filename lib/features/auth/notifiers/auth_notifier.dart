import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

import '../../../core/storage/secure_storage_service.dart';
import '../data/models/login_request.dart';
import '../data/repositories/auth_repository.dart';
import '../state/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._repository) : super(const AuthState());

  final AuthRepository _repository;

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    final result = await _repository.login(
      LoginRequest(
        email: email,
        password: password,
      ),
    );

    if (!result.isSuccess) {
      state = state.copyWith(
        isLoading: false,
        error: result.error,
      );

      return false;
    }

    state = state.copyWith(
      isLoading: false,
      isAuthenticated: true,
      user: result.data!.user,
      clearError: true,
    );

    return true;
  }

  Future<void> getProfile() async {
    final result = await _repository.me();

    if (!result.isSuccess) {
      state = state.copyWith(
        error: result.error,
      );
      return;
    }

    state = state.copyWith(
      isAuthenticated: true,
      user: result.data,
      clearError: true,
    );
  }

  Future<void> logout() async {
    state = state.copyWith(
      isLoading: true,
    );

    await _repository.logout();

    state = const AuthState();
  }

  Future<bool> checkAuth() async {
    debugPrint('CHECK AUTH');

    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    final token = await SecureStorageService.instance.getToken();

    debugPrint('TOKEN: $token');

    if (token == null) {
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        clearUser: true,
      );

      return false;
    }

    final result = await _repository.me();

    if (!result.isSuccess) {
      await SecureStorageService.instance.clear();

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        clearUser: true,
      );

      return false;
    }

    state = state.copyWith(
      isLoading: false,
      isAuthenticated: true,
      user: result.data,
    );

    return true;
  }
}
