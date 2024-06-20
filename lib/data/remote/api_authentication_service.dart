import 'package:task_manager/data/remote/response/login_response.dart';
import 'package:task_manager/data/remote/utils/base_service.dart';

abstract class ApiAuthenticationService {
  Future<LoginResponse> login(
      {required String username, required String password});

  Future<LoginResponse> refreshToken();
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
          data: {"username": username, "password": password},
        );
      },
      (body) => LoginResponse.fromJson(body),
    );
  }

  @override
  Future<LoginResponse> refreshToken() async {
    return await tryRequest(
      () {
        return client.post('/auth/refresh');
      },
      (body) => LoginResponse.fromJson(body),
    );
  }
}
