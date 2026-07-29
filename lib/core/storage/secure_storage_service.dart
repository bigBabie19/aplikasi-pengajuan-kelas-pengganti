import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/app_constants.dart';

class SecureStorageService {
  SecureStorageService._();

  static final instance = SecureStorageService._();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(
      key: AppConstants.accessTokenKey,
      value: token,
    );
  }

  Future<String?> getToken() async {
    return _storage.read(
      key: AppConstants.accessTokenKey,
    );
  }

  Future<void> deleteToken() async {
    await _storage.delete(
      key: AppConstants.accessTokenKey,
    );
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}