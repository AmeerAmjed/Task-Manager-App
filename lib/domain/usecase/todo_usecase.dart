import 'package:task_manager/data/repository/todo_repository_impl.dart';
import 'package:task_manager/domain/model/todo_model.dart';
import 'package:task_manager/domain/repository/todo_repository.dart';

class TodoUsease {
  final TodoRepository repo = TodoRepositoryImpl();

  Future<List<TodoModel>> getTodos({required int skip, required int limit}) {
    return repo.getTodos(skip: skip, limit: limit);
  }

  Future<bool> saveTodo(TodoModel todo) async {
    var isAdded = await repo.saveTodoInLocal(todo);
    if (isAdded is int) {
      return true;
    } else {
      return false;
    }
  }
}