import 'package:sqflite/sqlite_api.dart';
import 'package:task_manager/data/local/entity/todo_entity.dart';
import 'package:task_manager/data/local/utils/database_manager.dart';

const String _todoCacheTable = 'todoCacheTable';

class TodoCacheTable extends DatabaseManager<TodoEntity> {
  @override
  String tableName = _todoCacheTable;

  @override
  Future<void> createTable(Batch batch) async {
    batch.execute('''
      CREATE TABLE $tableName (
                    $id INTEGER PRIMARY KEY NOT NULL,
                    $userId INTEGER NOT NULL,
                    $title STRING NOT NULL,
                    $isCompleted INTEGER NOT NULL)
              ''');
  }
}
