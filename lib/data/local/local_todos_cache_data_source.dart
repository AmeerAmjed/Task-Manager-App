import 'package:task_manager/data/local/entity/todo_entity.dart';
import 'package:task_manager/data/local/table/todo_cache_tablle.dart';

abstract class LocalTodosCacheDataSource {
  Future<List<TodoEntity>> getTodos({
    required int offset,
    required int limit,
  });

  Future<void> saveTodos(List<TodoEntity> todos);
}

class LocalTodosCacheDataSourceImpl extends TodoCacheTable
    implements LocalTodosCacheDataSource {
  @override
  Future<List<TodoEntity>> getTodos({
    required int offset,
    required int limit,
  }) async {
    return await getDataWithPagination(offset: offset, limit: limit)
        .then((todos) {
      return todos.map((todo) => TodoEntity.fromJson(todo)).toList();
    }).onError((error, stackTrace) {
      return [];
    });
  }

  @override
  Future<void> saveTodos(List<TodoEntity> todos) async {
    await insertList(todos);
  }
}
