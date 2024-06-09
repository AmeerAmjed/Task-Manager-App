import 'package:task_manager/data/local/entity/todo_entity.dart';
import 'package:task_manager/data/local/table/todo_saved_tablle.dart';

abstract class LocalTodoDataSource {
  Future<int> saveTodo(TodoEntity todo);

  Future<void> unSaveTodoInLocal(int todoId);

  Future<List<TodoEntity>> getTodosSaved();
}

class LocalTodoDataSourceImpl extends TodoSavedTable implements LocalTodoDataSource {
  @override
  Future<int> saveTodo(TodoEntity todos) {
    return insert(todos);
  }

  @override
  Future<void> unSaveTodoInLocal(int todoId) async {
    await delete(todoId);
  }

  @override
  Future<List<TodoEntity>> getTodosSaved() async {
    return await getEventTableData().then(
        (todos) => todos.map((todo) => TodoEntity.fromJson(todo)).toList());
  }
}
