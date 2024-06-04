import 'package:dio/dio.dart';
import 'package:task_manager/data/local/local_secure_data_source.dart';
import 'package:task_manager/data/remote/api_authentication_service.dart';
import 'package:task_manager/data/remote/response/login_response.dart';
import 'package:task_manager/di/get_it.dart';

class AuthInterceptor extends QueuedInterceptorsWrapper {
  final LocalSecureDataSource _localSecureDataSource =
      getIt.get<LocalSecureDataSource>();

  final ApiAuthenticationService authenticationService =
      getIt.get<ApiAuthenticationService>();

  final Dio client = getIt.get<Dio>();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final String? accessToken = await _localSecureDataSource.getToken();
    if (accessToken != null) {
      options.headers.addAll({'Authorization': 'Bearer $accessToken'});
    }

    print("TOKEN $accessToken");

    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    print("type error dio ${err.type}");
    if (err.type == DioExceptionType.badResponse &&
        err.response?.statusCode == 401) {
      final String? accessToken = await _localSecureDataSource.getToken();
      if (accessToken != null) {
        LoginResponse authResponse = await authenticationService.refreshToken();
        _localSecureDataSource.saveToken(authResponse.token);
        handler.resolve(await _retry(err.requestOptions));
      } else {
        handler.reject(err);
      }
    }
    super.onError(err, handler);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    return client.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
      ),
    );
  }
}
