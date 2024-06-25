import 'package:dio/dio.dart';
import 'package:task_manager/data/local/local_secure_data_source.dart';
import 'package:task_manager/data/remote/api_authentication_service.dart';
import 'package:task_manager/data/remote/response/tokens_response.dart';
import 'package:task_manager/di/get_it.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.client);

  final Dio client;
  bool _isRefreshing = false;
  final List<Function()> _queuedRequests = [];
  final LocalSecureDataSource _localSecureDataSource =
      getIt<LocalSecureDataSource>();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final String? accessToken = await _localSecureDataSource.getToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    print("AMEERX onRequest TOKEN $accessToken");

    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    bool isUnauthorized = err.response?.statusCode == 401;
    if (isUnauthorized && !_isRefreshing) {
      await _handleUnauthorizedError(err, handler);
    } else if (isUnauthorized && _isRefreshing) {
      _queuedRequests.add(
        () => _retry(err.requestOptions)
            .then(handler.resolve)
            .catchError((error) => handler.reject(err)),
      );
    } else {
      handler.reject(err);
    }
  }

  Future<void> _handleUnauthorizedError(
      DioException err, ErrorInterceptorHandler handler) async {
    print("AMEERX not auth");
    _isRefreshing = true;

    final String? refreshToken = await _localSecureDataSource.getRefreshToken();
    if (refreshToken == null) {
      handler.reject(err);
      return;
    }

    try {
      await refreshAndSaveTokens(refreshToken);
      _queuedRequests.forEach((callback) => callback());
      _queuedRequests.clear();
      handler.resolve(await _retry(err.requestOptions));
    } catch (e) {
      print("AMEERX token refresh error: $e");
      handler.reject(err);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<void> refreshAndSaveTokens(String refreshToken) async {
    print("AMEERX refresh and SaveTokens");
    TokensResponse tokensResponse =
        await getIt<ApiAuthenticationService>().refreshToken(refreshToken);
    await _localSecureDataSource.saveTokens(
      token: tokensResponse.token,
      refreshToken: tokensResponse.refreshToken,
    );
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final String? accessToken = await _localSecureDataSource.getToken();
    requestOptions.headers['Authorization'] = 'Bearer $accessToken';
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
