import 'package:task_manager/domain/model/todo_model.dart';

abstract class TodoRepository {
  Future<List<TodoModel>> getTodos({required int skip, required int limit});

  Future<List<TodoModel>> getTodosFromLocal(
      {required int offset, required int limit});

  Future<int> saveTodoInLocal(TodoModel todos);
  Future<List<TodoModel>> getTodosSaved();
}
