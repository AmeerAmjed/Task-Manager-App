import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class LocalSecureDataSource {
  Future<String?> getToken();

  Future<void> saveToken(String token);

  Future<void> deleteToken();
}

class LocalSecureDataSourceImpl implements LocalSecureDataSource {
  LocalSecureDataSourceImpl(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  @override
  Future<String?> getToken() {
    return _secureStorage.read(key: _token);
  }

  @override
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _token, value: token);
  }

  @override
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _token);
  }

  static const _token = "token";
}
