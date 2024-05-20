import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/data/remote/api_todo_service.dart';
import 'package:task_manager/data/remote/response/todos_response.dart';

import 'api_todo_service_test.mocks.dart';

@GenerateMocks([Dio, ApiToDoServiceImpl])
void main() {
  late MockDio client;
  late MockApiToDoServiceImpl apiService;

  setUp(() {
    client = MockDio();
    apiService = MockApiToDoServiceImpl();
  });

  group('constructor', () {
    test('check apiService in provide as well', () {
      expect(apiService, isNotNull);
    });
  });

  group('getTodos', () {
    test('getTodos returns TodosResponse on success', () async {
      // give in
      final fakeResponse = jsonEncode({
        "todos": [
          {
            "id": 1,
            "todo": "Do something nice for someone I care about",
            "completed": true,
            "userId": 26
          },
        ],
        "total": 1,
        "skip": 0,
        "limit": 1
      });

      final Map<String, dynamic> decodedJson = jsonDecode(fakeResponse);
      final todosResponse = TodosResponse.fromJson(decodedJson);

      //when
      when(apiService.getTodos(skip: 0, limit: 1))
          .thenAnswer((_) async => todosResponse);

      // Act
      final result = await apiService.getTodos(skip: 0, limit: 1);

      // Assert
      expect(result, equals(todosResponse));
    });

    test('check type response on success', () async {
      // give in
      final fakeResponse = jsonEncode({
        "todos": [
          {
            "id": 1,
            "todo": "Do something nice for someone I care about",
            "completed": true,
            "userId": 26
          },
        ],
        "total": 1,
        "skip": 0,
        "limit": 1
      });

      final Map<String, dynamic> decodedJson = jsonDecode(fakeResponse);
      final todosResponse = TodosResponse.fromJson(decodedJson);

      //when
      when(apiService.getTodos(skip: 0, limit: 1))
          .thenAnswer((_) async => todosResponse);

      // Act
      final result = await apiService.getTodos(skip: 0, limit: 1);

      // Assert
      expect(result, isA<TodosResponse>());
    });


  });
}
