import 'package:task_manager/data/remote/response/login_response.dart';
import 'package:task_manager/data/remote/response/tokens_response.dart';
import 'package:task_manager/data/remote/utils/base_service.dart';

abstract class ApiAuthenticationService {
  Future<LoginResponse> login(
      {required String username, required String password});

  Future<TokensResponse> refreshToken(String token);
}

class ApiAuthenticationServiceImpl extends BaseApiService
    implements ApiAuthenticationService {
  ApiAuthenticationServiceImpl({required super.client});

  @override
  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    return await tryRequest(
      () {
        return client.post(
          '/auth/login',
          data: {
            "username": username,
            "password": password,
          },
        );
      },
      (body) => LoginResponse.fromJson(body),
    );
  }

  @override
  Future<TokensResponse> refreshToken(String token) async {
    print("refreshToken get");
    return await tryRequest(
      () {
        return client.post(
          '/auth/refresh',
          data: {"refreshToken": token},
        );
      },
      (body) => TokensResponse.fromJson(body),
    );
  }
}
