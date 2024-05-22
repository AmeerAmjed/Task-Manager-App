import 'package:task_manager/data/local/entity/todo_entity.dart';
import 'package:task_manager/data/local/table/todo_tablle.dart';

abstract class LocalTodoDataSource {
  Future<int> saveTodos(TodoEntity user);

  Future<List<TodoEntity>> getTodos({
    required int offset,
    required int limit,
  });
}

class LocalTodoDataSourceImpl extends TodoTable implements LocalTodoDataSource {
  @override
  Future<int> saveTodos(TodoEntity todos) {
    return insert(todos);
  }

  @override
  Future<List<TodoEntity>> getTodos({
    required int offset,
    required int limit,
  }) async {
    return await getDataWithPagination(offset: offset, limit: limit)
        .then((todos) {
      return todos.map((todo) => TodoEntity.fromJson(todo)).toList();
    });
  }
}
