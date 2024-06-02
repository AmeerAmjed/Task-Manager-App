import 'package:task_manager/data/repository/todo_repository_impl.dart';
import 'package:task_manager/domain/model/todo_model.dart';
import 'package:task_manager/domain/repository/todo_repository.dart';

class TodoUsease {
  final TodoRepository repo = TodoRepositoryImpl();

  Future<List<TodoModel>> getTodos({
    required int skip,
    required int limit,
  }) async {
    final cachedTodos =
        await repo.getTodosFromLocal(offset: skip, limit: limit);
    print("cachedTodos $skip  $cachedTodos");
    if (cachedTodos.isNotEmpty) {
      print("cachedTodos isNotEmpty");
      return cachedTodos;
    }

    final todos = await repo.getTodos(skip: skip, limit: limit);
    await repo.saveTodosInLocal(todos);
    return getTodos(skip: skip, limit: limit);
  }

  Future<bool> saveTodo(TodoModel todo) async {
    var isAdded = await repo.saveTodoInLocal(todo);
    if (isAdded is int) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteTodo(int todoId) async {
    return await repo.deleteTodo(todoId);
  }

  Future<bool> createTodo({
    required String title,
    required bool isCompleted,
  }) async {
    return await repo.createTodo(
      title: title,
      isCompleted: isCompleted,
    );
  }

  Future<List<TodoModel>> getTodosSaved() {
    return repo.getTodosSaved();
  }
}