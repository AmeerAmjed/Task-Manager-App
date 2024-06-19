import 'dart:io';

import 'package:dio/dio.dart';
import 'package:task_manager/data/remote/utils/auth_interceptor.dart';
import 'package:task_manager/data/remote/utils/todo_api_endpoint.dart';
import 'package:task_manager/utils/handle_error.dart';

abstract class BaseApiService with TodoApiEndpoint {
  final Dio client;

  BaseApiService({required this.client}) {
    client.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,
      headers: {
        'Accept': 'application/json',
      },
    );

    //client.interceptors.add(AuthInterceptor());
    client.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<T> tryRequest<T>(
    Future<Response> request,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      print("tryRequest");

      Response response = await request;
      print("response ${response.statusCode}");

      if (_isRequestSuccess(response)) {
        if (response.data != null && (response.data is Map<String, dynamic>)) {
          print(" data is convert to");
          return fromJson(response.data);
        } else {
          print("Body is null ");
          throw const BadRequestException(message: "Body is null");
        }
      } else {
        print("Request not Success ");
        throw const BadRequestException();
      }
    } on DioException catch (e) {
      print("DioException ");
      if (e.response != null) {
        if (e.response?.statusCode == HttpStatus.badRequest) {
          throw const BadRequestException(message: "Invalid credentials");
        } else {
          throw ServerException(
              message: e.response?.data.toString() ?? "Unknown error");
        }
      } else {
        throw ServerException(message: e.message ?? "Unknown error");
      }
    } on ServerException catch (e) {
      print("ServerException ");
      throw const ServerException(message: "Unknown error");
    }
  }

  bool _isRequestSuccess(Response response) =>
      response.statusCode != null && response.statusCode! ~/ 100 == 2;
}
