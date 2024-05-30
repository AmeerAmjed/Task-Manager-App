import 'package:dio/dio.dart';
import 'package:task_manager/data/remote/response/login_response.dart';
import 'package:task_manager/data/remote/utils/todo_api_endpoint.dart';
import 'package:task_manager/utils/handle_error.dart';

abstract class ApiAuthenticationService {
  Future<LoginResponse> login(
      {required String username, required String password});
}

class ApiAuthenticationServiceImpl extends ApiAuthenticationService
    with TodoApiEndpoint {
  ApiAuthenticationServiceImpl({required this.client});

  final Dio client;

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
}
