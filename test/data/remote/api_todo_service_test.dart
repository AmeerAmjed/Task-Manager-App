import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/data/remote/api_todo_service.dart';
import 'package:task_manager/data/remote/model/create_todo_params.dart';
import 'package:task_manager/data/remote/response/todos_response.dart';
import 'package:task_manager/utils/handle_error.dart';

import 'api_todo_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio client;
  late ApiToDoService apiService;

  setUp(() {
    client = MockDio();
    final fakeInterceptors = Interceptors();
    when(client.interceptors).thenReturn(fakeInterceptors);

    apiService = ApiToDoServiceImpl(client: client);
  });

  group('ApiToDoService', () {
    group('getTodos', () {
      test('getTodos returns TodosResponse on success', () async {
        //Arrange
        final fakeResponse = {
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
        };

        final response = Response(
          data: fakeResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/todos'),
        );

        //when
        when(client.get(
          '/todos',
          queryParameters: {
            'skip': 0,
            'limit': 1,
          },
        )).thenAnswer((_) async => response);

        // Act
        final result = await apiService.getTodos(skip: 0, limit: 1);

        // Assert
        expect(result, isA<TodosResponse>());
      });

      test('returns TodosResponse on success', () async {
        // Arrange
        final fakeResponse = {
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
        };

        final response = Response(
          data: fakeResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/todos'),
        );

        // When
        when(client.get(
          '/todos',
          queryParameters: {
            'skip': 0,
            'limit': 1,
          },
        )).thenAnswer((_) async => response);

        // Act
        final result = await apiService.getTodos(skip: 0, limit: 1);

        // Assert
        expect(result, isA<TodosResponse>());
        expect(result.todos.length, equals(1));
      });

      test('returns empty TodosResponse when there are no todos', () async {
        // Arrange
        final fakeResponse = {"todos": [], "total": 0, "skip": 0, "limit": 1};

        final response = Response(
          data: fakeResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/todos'),
        );

        // When
        when(client.get(
          '/todos',
          queryParameters: {
            'skip': 0,
            'limit': 1,
          },
        )).thenAnswer((_) async => response);

        // Act
        final result = await apiService.getTodos(skip: 0, limit: 1);

        // Assert
        expect(result.todos, isEmpty);
      });

      test('returns TodosResponse with many todos', () async {
        // Arrange
        final fakeResponse = {
          "todos": List.generate(
              100,
              (index) => {
                    "id": index,
                    "todo": "Task $index",
                    "completed": index % 2 == 0,
                    "userId": index % 10
                  }),
          "total": 100,
          "skip": 0,
          "limit": 100
        };

        final response = Response(
          data: fakeResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/todos'),
        );

        // When
        when(client.get(
          '/todos',
          queryParameters: {
            'skip': 0,
            'limit': 100,
          },
        )).thenAnswer((_) async => response);

        // Act
        final result = await apiService.getTodos(skip: 0, limit: 100);

        // Assert
        expect(result, isA<TodosResponse>());
        expect(result.todos.length, equals(100));
      });
    });

    group('deleteTodo', () {
      test(
          'should return response with isDeleted true when item deletion success',
          () async {
        //Arrange
        const todoId = 1;
        final fakeResponse = {
          "id": 1,
          "todo": "Do something nice for someone I care about",
          "completed": true,
          "isDeleted": true,
          "userId": 26
        };

        final response = Response(
          data: fakeResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/todos/$todoId'),
        );

        //when
        when(client.delete(any)).thenAnswer((_) async => response);
        // Act
        final result = await apiService.deleteTodo(todoId: 1);

      // Assert
      expect(result.isDeleted, isTrue);
    });

      test(
          'should return response with isDeleted false when item deletion fails',
          () async {
        //Arrange
        const todoId = 1;
        final fakeResponse = {
          "id": 1,
          "todo": "Do something nice for someone I care about",
          "completed": true,
          "isDeleted": false,
          "userId": 26
        };

        final response = Response(
          data: fakeResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/todos/$todoId'),
        );

        //when
            when(client.delete(any)).thenAnswer((_) async => response);
      // Act
      final result = await apiService.deleteTodo(todoId: 1);

      // Assert
      expect(result.isDeleted, isFalse);
    });

      test('should throw NotFoundException when todo id not exist', () async {
        //Arrange
        const todoId = 500;

        final response = Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: '/todos/$todoId'),
            data: {"message": "Todo with id $todoId not found"});

        //when
        when(client.delete(any)).thenAnswer((_) async => response);

        // Assert
        expect(
          () async => await apiService.deleteTodo(todoId: todoId),
          throwsA(isA<NotFoundException>()),
        );
      });

      test('should throw ServerException when server error', () async {
        //Arrange
        const todoId = 1;

        final response = Response(
          statusCode: 500,
          requestOptions: RequestOptions(path: '/todos/$todoId'),
        );

        //when
        when(client.delete(any)).thenAnswer((_) async => response);

        // Assert
        expect(
          () async => await apiService.deleteTodo(todoId: todoId),
          throwsA(isA<ServerException>()),
        );
      });
    });

    group('createTodo', () {
      test('should return TodosResponse when successfully create a todo',
          () async {
        //Arrange
        final fakeResponse = {
          "id": 1,
          "todo": "Do something nice for someone I care about",
          "completed": true,
          "userId": 26
        };

        final response = Response(
                statusCode: 200,
                requestOptions: RequestOptions(path: '/todos/add'),
                data: fakeResponse
            );
            //When
            when(client.post(any, data: anyNamed('data'))).thenAnswer((
                _) async => response);

            //Act
            final result = await apiService.createTodo(
              todo: const CreateTodoParams(
                userId: 1,
                title: "Do something nice for someone I care about",
                isCompleted: true,
              ),
            );

        //Assert
        expect(result, true);
      });

      test('should throw ServerException when userId not exits', () async {
        //Arrange
        final fakeResponse = {
          "todo": "Do something nice for someone I care about",
          "completed": true,
          "userId": 5000
        };
        const userInput = CreateTodoParams(
          userId: 5000,
          title: "Do something nice for someone I care about",
          isCompleted: true,
        );
        final response = Response(
          statusCode: 400,
          requestOptions: RequestOptions(path: '/todos/add'),
          data: fakeResponse,
        );

        //When
        when(client.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => response);

        // Assert
        expect(
          () async => await apiService.createTodo(todo: userInput),
          throwsA(isA<ServerException>()),
        );
      });
    });

    test('should throw Exception when missing required fields', () async {
      // Arrange
      final fakeResponse = {"error": "Missing required fields"};
      const userInput = CreateTodoParams(
        userId: 1,
        title: "",
        isCompleted: true,
      );
      final response = Response(
        statusCode: 400,
        requestOptions: RequestOptions(path: '/todos/add'),
        data: fakeResponse,
      );

      // When
      when(client.post(any, data: anyNamed('data')))
          .thenAnswer((_) async => response);

      // Assert
      expect(
        () async => await apiService.createTodo(todo: userInput),
        throwsA(isA<Exception>()),
      );
    });

    test('should throw ServerException when server error occurs', () async {
      // Arrange
      final fakeResponse = {"error": "Internal server error"};
      const userInput = CreateTodoParams(
        userId: 1,
        title: "Do something nice for someone I care about",
        isCompleted: true,
      );
      final response = Response(
        statusCode: 500,
        requestOptions: RequestOptions(path: '/todos/add'),
        data: fakeResponse,
      );

      // When
      when(client.post(any, data: anyNamed('data')))
          .thenAnswer((_) async => response);

      // Assert
      expect(
        () async => await apiService.createTodo(todo: userInput),
        throwsA(isA<ServerException>()),
      );
    });

  });
}
