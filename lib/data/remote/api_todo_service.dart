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
  ApiToDoServiceImpl({required super.client});
  @override
  Future<TodosResponse> getTodos({
    required int skip,
    required int limit,
  }) async {
    return await tryRequest<TodosResponse>(
      () {
        return client.get(
          '/auth/todos',
          queryParameters: {
            "skip": skip,
            "limit": limit,
          },
        );
      },
      (json) => TodosResponse.fromJson(json),
    );
  }

  @override
  Future<DeleteTodoResponse> deleteTodo({required int todoId}) async {
    return await tryRequest<DeleteTodoResponse>(
      () {
        return client.delete('$baseUrl/todos/$todoId');
      },
      (json) => DeleteTodoResponse.fromJson(json),
    );
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
