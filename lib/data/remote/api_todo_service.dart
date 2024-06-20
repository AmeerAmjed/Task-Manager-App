import 'package:dio/dio.dart';
import 'package:task_manager/data/remote/model/create_todo_params.dart';
import 'package:task_manager/data/remote/response/delete_todo_response.dart';
import 'package:task_manager/data/remote/response/todo_dto.dart';
import 'package:task_manager/data/remote/response/todo_response.dart';
import 'package:task_manager/data/remote/response/todos_response.dart';
import 'package:task_manager/data/remote/utils/base_service.dart';

abstract class ApiToDoService {
  Future<TodosResponse> getTodos({required int skip, required int limit});

  Future<DeleteTodoResponse> deleteTodo({required int todoId});

  Future<bool> createTodo({required CreateTodoParams todo});

  Future<bool> updateTodoIsCompleted({
    required int todoId,
    required bool isCompleted,
  });
}

class ApiToDoServiceImpl extends BaseApiService implements ApiToDoService {
  ApiToDoServiceImpl(Dio client) : super(client: client);

  @override
  Future<TodosResponse> getTodos(
      {required int skip, required int limit}) async {
    try {
      final response = await client.get(
        '$baseUrl/todos',
        queryParameters: {
          "skip": skip,
          "limit": limit,
        },
      );

      if (response.statusCode == 200) {
        return TodosResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load todos');
      }
    } catch (e) {
      throw Exception('Failed to load todos: $e');
    }
  }

  @override
  Future<DeleteTodoResponse> deleteTodo({required int todoId}) async {
    try {
      final response = await client.delete('$baseUrl/todos/$todoId');

      if (response.statusCode == 200) {
        if (response.data != null) {
          return DeleteTodoResponse.fromJson(response.data);
        } else {
          throw Exception('Failed to delete todo');
        }
      } else {
        throw Exception('Failed to delete todo');
      }
    } catch (e) {
      throw Exception('Failed to delete todo: $e');
    }
  }

  @override
  Future<bool> createTodo({required CreateTodoParams todo}) async {
    return await tryRequest<TodoDto>(
      () {
        return client.post(
          '/todos/add',
          data: todo.toBody(),
        );
      },
      (json) => TodoDto.fromJson(json),
    ).then((value) {
      return true;
    });
  }

  @override
  Future<bool> updateTodoIsCompleted({
    required int todoId,
    required bool isCompleted,
  }) async {
    return await tryRequest<TodoResponse>(
      () {
        return client.put(
          '/todos/$todoId',
          data: {
            "completed": isCompleted,
          },
        );
      },
      (json) => TodoResponse.fromJson(json),
    ).then((todo) => todo.id == todoId);
  }
}
