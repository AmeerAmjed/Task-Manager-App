import 'package:dio/dio.dart';
import 'package:task_manager/data/remote/utils/todo_api_endpoint.dart';
import 'package:task_manager/utils/handle_error.dart';

abstract class BaseApiService with TodoApiEndpoint {
  final Dio client;

  BaseApiService({required this.client}) {
    client.options.baseUrl = baseUrl;
    client.options.connectTimeout = const Duration(minutes: 1);
    client.options.receiveTimeout = const Duration(minutes: 1);
    client.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<T> tryRequest<T>(
    Future<Response> request,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      Response response = await request;
      if (isRequestSuccess(response)) {
        if (response.data != null && (response.data is Map<String, dynamic>)) {
          return fromJson(response.data);
        } else {
          throw const BadRequestException(message: "Body is null");
        }
      } else {
        throw const BadRequestException();
      }
    } catch (e) {
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

  bool isRequestSuccess(Response response) =>
      response.statusCode != null && response.statusCode! ~/ 100 == 2;
}
