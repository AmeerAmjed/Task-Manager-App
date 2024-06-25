import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class LocalSecureDataSource {
  Future<String?> getToken();

  Future<String?> getRefreshToken();

  Future<void> saveTokens({
    required String token,
    required String refreshToken,
  });

  Future<void> deleteTokens();
}

class LocalSecureDataSourceImpl implements LocalSecureDataSource {
  LocalSecureDataSourceImpl(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  @override
  Future<String?> getToken() {
    return _secureStorage.read(key: _token);
  }

  @override
  Future<String?> getRefreshToken() {
    return _secureStorage.read(key: _refreshToken);
  }

  @override
  Future<void> saveTokens({
    required String token,
    required String refreshToken,
  }) async {
    await _secureStorage.write(key: _token, value: token);
    await _secureStorage.write(key: _refreshToken, value: refreshToken);
  }

  @override
  Future<void> deleteTokens() async {
    await _secureStorage.delete(key: _token);
    await _secureStorage.delete(key: _refreshToken);
  }

  static const _token = "token";
  static const _refreshToken = "refreshToken";
}
