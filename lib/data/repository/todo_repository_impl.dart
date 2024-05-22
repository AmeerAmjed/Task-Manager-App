import 'package:dio/dio.dart';
import 'package:task_manager/data/local/local_todo_data_source.dart';
import 'package:task_manager/data/local/mapper/to_todo_entity.dart';
import 'package:task_manager/data/local/mapper/to_todo_model.dart';
import 'package:task_manager/data/remote/api_todo_service.dart';
import 'package:task_manager/data/remote/mapper/to_todo_model.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/domain/model/todo_model.dart';
import 'package:task_manager/domain/repository/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  final ApiToDoService api = ApiToDoServiceImpl(client: getIt<Dio>());
  final LocalTodoDataSource localTodoDataSource =
      getIt.get<LocalTodoDataSource>();

  @override
  Future<List<TodoModel>> getTodos({required int skip, required int limit}) {
    return api.getTodos(skip: skip, limit: limit).then((value) {
      return value.todos.map((todo) => todo.toToDoModel()).toList();
    });
  }

  @override
  Future<List<TodoModel>> getTodosFromLocal({
    required int offset,
    required int limit,
  }) {
    return localTodoDataSource.getTodos(offset: offset, limit: limit).then(
          (todos) => todos.map((todo) => todo.toTodoModel()).toList(),
        );
  }

  @override
  Future<int> saveTodoInLocal(TodoModel todos) async {
    return localTodoDataSource.saveTodos(todos.toTodoModel());
  }
}
