import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/data/remote/api_authentication_service.dart';
import 'package:task_manager/data/remote/response/login_response.dart';
import 'package:task_manager/utils/handle_error.dart';

import 'api_authentication_service_test.mocks.dart';

@GenerateMocks([Dio, ApiAuthenticationServiceImpl])
void main() {
  late MockDio client;
  late ApiAuthenticationServiceImpl apiService;
  const fakeLoginSuccessResponse = {
    "id": 30,
    "username": "AMeero",
    "email": "example@f.com",
    "firstName": "AMeero",
    "lastName": "Xyz",
    "gender": "male",
    "image": "https://robohash.org/Jeanne.png?set=set4",
    "token": "tokennn"
  };

  setUp(() {
    client = MockDio();
    apiService = ApiAuthenticationServiceImpl(client: client);
  });

  group('ApiAuthenticationServiceImpl', () {
    group('login', () {
      test('returns LoginResponse when successful login', () async {
        final response = Response(
          data: fakeLoginSuccessResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );

        when(client.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => response);

        final result =
            await apiService.login(username: 'test', password: 'test');

        expect(result, isA<LoginResponse>());
      });

      test('server return token when successful login', () async {
        final response = Response(
          data: fakeLoginSuccessResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );

        when(client.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => response);

        final result =
            await apiService.login(username: 'test', password: 'test');

        expect(result.token, isNotNull);
      });

      test('throws ServerException when DioError without response', () async {
        when(client.post(any, data: anyNamed('data')))
            .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

        expect(
          () async =>
              await apiService.login(username: 'test', password: 'test'),
          throwsA(isA<ServerException>()),
        );
      });

      test('throws ServerException when DioError with non-400 response',
          () async {
        final response = Response(
          statusCode: 500,
          requestOptions: RequestOptions(path: ''),
        );

        when(client.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => response);

        expect(
          () async =>
              await apiService.login(username: 'test', password: 'test'),
          throwsA(isA<ServerException>()),
        );
      });

      test('throws BadRequestException when 400 status code', () async {
        final response = Response(
          statusCode: 400,
          requestOptions: RequestOptions(path: '/auth/login'),
        );

        when(client.post(any, data: anyNamed('data'))).thenThrow(DioException(
          response: response,
          requestOptions: RequestOptions(path: '/auth/login'),
          type: DioExceptionType.badResponse,
        ));

        expect(
          () async =>
              await apiService.login(username: 'test', password: 'test'),
          throwsA(isA<BadRequestException>()),
        );
      });
    });
  });
}
