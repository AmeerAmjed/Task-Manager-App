import 'dart:io';

import 'package:dio/dio.dart';
import 'package:task_manager/data/remote/utils/auth_interceptor.dart';
import 'package:task_manager/data/remote/utils/todo_api_endpoint.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/utils/handle_error.dart';

abstract class BaseApiService with TodoApiEndpoint {
  final Dio client;

  BaseApiService({required this.client}) {
    client.options = BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: const Duration(minutes: 1),
      sendTimeout: const Duration(minutes: 1),
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,
      headers: {
        'Accept': 'application/json',
      },
    );

    client.interceptors.add(getIt.get<AuthInterceptor>());
    client.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<T> tryRequest<T>(Future<Response> Function() request,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      Response response = await request();

      if (_isRequestSuccess(response)) {
        if (response.data != null && (response.data is Map<String, dynamic>)) {
          return fromJson(response.data);
        } else {
          throw const BadRequestException(message: "Body is null");
        }
      } else if (response.statusCode == HttpStatus.notFound) {
        throw NotFoundException(response.data['message'] ?? "Not Found");
      } else {
        throw const BadRequestException();
      }
    } on DioException catch (e) {
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
    } on NotFoundException catch (e) {
      throw NotFoundException(e.message);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  bool _isRequestSuccess(Response response) =>
      response.statusCode != null && response.statusCode! ~/ 100 == 2;
}
