import 'package:dio/dio.dart';
import 'package:task_manager/data/remote/response/login_response.dart';
import 'package:task_manager/data/remote/utils/base_service.dart';
import 'package:task_manager/utils/handle_error.dart';

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

    try {
      final response = await client.post(
        '$baseUrl/auth/login',
        data: {"username": username, "password": password},
      );

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw BadRequestException;
      }
    } catch (e) {
      if (e is BadRequestException) {
        throw const BadRequestException(message: "Invalid credentials");
      }
      if (e is DioException) {
        if (e.response != null) {
          if (e.response?.statusCode == 400) {
            throw const BadRequestException(message: "Invalid credentials");
          } else {
            throw ServerException(message: e.toString());
          }
        } else {
          throw ServerException(message: e.message ?? "");
        }
      } else {
        throw ServerException(message: e.toString());
      }
    }
  }

  @override
  Future<LoginResponse> refreshToken() async {
    return await tryRequest(
      client.post('/auth/refresh'),
      (body) => LoginResponse.fromJson(body),
    );
  }
}
