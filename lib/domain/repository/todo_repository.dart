import 'package:task_manager/domain/model/todo_model.dart';

abstract class TodoRepository {
  Future<List<TodoModel>> getTodos({required int skip, required int limit});

  Future<List<TodoModel>> getTodosFromLocal(
      {required int offset, required int limit});

  Future<int> saveTodoInLocal(TodoModel todos);

  Future<void> saveTodosInLocal(List<TodoModel> todos);

  Future<bool> deleteTodo(int todoId);

  Future<bool> createTodo({required String title, required bool isCompleted});

  Future<List<TodoModel>> getTodosSaved();
}
