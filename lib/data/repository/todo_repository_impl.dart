import 'package:dio/dio.dart';
import 'package:task_manager/data/local/local_todo_data_source.dart';
import 'package:task_manager/data/local/local_todos_cache_data_source.dart';
import 'package:task_manager/data/local/local_user_data_source.dart';
import 'package:task_manager/data/local/mapper/to_todo_entity.dart';
import 'package:task_manager/data/local/mapper/to_todo_model.dart';
import 'package:task_manager/data/remote/api_todo_service.dart';
import 'package:task_manager/data/remote/mapper/to_todo_model.dart';
import 'package:task_manager/data/remote/model/create_todo_params.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/domain/model/todo_model.dart';
import 'package:task_manager/domain/repository/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  final ApiToDoService api = ApiToDoServiceImpl(client: getIt<Dio>());
  final LocalTodoDataSource localTodoDataSource =
      getIt.get<LocalTodoDataSource>();

  final LocalTodosCacheDataSource localTodosCacheDataSource =
      getIt.get<LocalTodosCacheDataSource>();

  final UserLocalDataSource userLocalDataSource =
      getIt.get<UserLocalDataSource>();

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
    return localTodosCacheDataSource.getTodos(offset: offset, limit: limit).then(
          (todos) => todos.map((todo) => todo.toTodoModel()).toList(),
        );
  }

  @override
  Future<int> saveTodoInLocal(TodoModel todos) async {
    return localTodoDataSource.saveTodo(todos.toTodoModel());
  }

  @override
  Future<void> unSaveTodoInLocal(int todoId) async {
    return await localTodoDataSource.unSaveTodoInLocal(todoId);
  }

  @override
  Future<List<TodoModel>> getTodosSaved() {
    return localTodoDataSource.getTodosSaved().then(
          (todos) => todos.map((todo) => todo.toTodoModel()).toList(),
        );
  }

  @override
  Future<bool> deleteTodo(int todoId) {
    return api.deleteTodo(todoId: todoId).then((value) {
      return value.isDeleted;
    });
  }

  @override
  Future<bool> createTodo({
    required String title,
    required bool isCompleted,
  }) async {
    return api
        .createTodo(
          todo: CreateTodoParams(
            userId: await userLocalDataSource.getUserId(),
            title: title,
            isCompleted: isCompleted,
          ),
        )
        .then((value) => value);
  }

  @override
  Future<void> saveTodosInLocal(List<TodoModel> todos) {
    return localTodosCacheDataSource.saveTodos(todos
        .map(
          (todo) => todo.toTodoModel(),
        )
        .toList());
  }

  @override
  Future<bool> updateTodoIsCompleted({
    required int todoId,
    required bool isCompleted,
  }) {
    return api.updateTodoIsCompleted(todoId: todoId, isCompleted: isCompleted);
  }
}
