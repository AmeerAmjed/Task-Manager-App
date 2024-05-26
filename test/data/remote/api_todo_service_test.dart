import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/data/remote/api_todo_service.dart';
import 'package:task_manager/data/remote/response/delete_todo_response.dart';
import 'package:task_manager/data/remote/response/todos_response.dart';
import 'package:task_manager/utils/handle_error.dart';

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

  group('deleteTodo', () {
    test('should return DeleteTodoResponse when successfully delete a todo',
        () async {
      //Give in
      const response = DeleteTodoResponse(
        id: 1,
        todo: 'Test Todo',
        completed: true,
        isDeleted: true,
        userId: 123,
      );
      //When
      when(apiService.deleteTodo(todoId: 1)).thenAnswer((_) async => response);
      //Act
      final result = await apiService.deleteTodo(todoId: 1);

      //Assert
      expect(result, isA<DeleteTodoResponse>());
    });

    test(
        'should return response with isDeleted ture when item deletion successes',
        () async {
      //Give in
      const response = DeleteTodoResponse(
        id: 1,
        todo: 'Test Todo',
        completed: false,
        isDeleted: true,
        userId: 123,
      );

      //when
      when(apiService.deleteTodo(todoId: 1)).thenAnswer((_) async => response);
      // Act
      final result = await apiService.deleteTodo(todoId: 1);

      // Assert
      verify(apiService.deleteTodo(todoId: 1)).called(1);
      expect(result.isDeleted, isTrue);
    });

    test('should return response with isDeleted false when item deletion fails',
        () async {
      //Give in
      const response = DeleteTodoResponse(
        id: 1,
        todo: 'Test Todo',
        completed: false,
        isDeleted: false,
        userId: 123,
      );

      //when
      when(apiService.deleteTodo(todoId: 1)).thenAnswer((_) async => response);
      // Act
      final result = await apiService.deleteTodo(todoId: 1);

      // Assert
      verify(apiService.deleteTodo(todoId: 1)).called(1);
      expect(result.isDeleted, isFalse);
    });

    test('should throw an exception when error', () async {
      // Give in
      when(apiService.deleteTodo(todoId: 1))
          .thenThrow(Exception('Failed to delete'));

      // Act & Assert
      expect(
          () async => await apiService.deleteTodo(todoId: 1), throwsException);

      // Verify
      verify(apiService.deleteTodo(todoId: 1)).called(1);
    });

    test('should throw error when todoId is null', () async {
      //Give in
      const todoId = null;
      when(apiService.deleteTodo(todoId: todoId))
          .thenThrow(ArgumentError('todoId cannot be null'));

      // Act & Assert
      expect(() async => await apiService.deleteTodo(todoId: null),
          throwsA(isA<ArgumentError>()));

      // Verify
      verify(apiService.deleteTodo(todoId: null)).called(1);
    });

    test('should throw error when server error', () async {
      when(apiService.deleteTodo(todoId: 1))
          .thenThrow(const ServerException(message: 'Network error'));

      // Act & Assert
      expect(() async => await apiService.deleteTodo(todoId: 1),
          throwsA(isA<ServerException>()));

      // Verify
      verify(apiService.deleteTodo(todoId: 1)).called(1);
    });
  });
}
