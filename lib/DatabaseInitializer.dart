import 'package:task_manager/data/local/table/todo_cache_tablle.dart';
import 'package:task_manager/data/local/table/todo_saved_tablle.dart';
import 'package:task_manager/data/local/table/user_table.dart';
import 'package:task_manager/data/local/utils/database_manager.dart';

class DatabaseInitializer {
  static Future<void> initialize() async {
    await DatabaseManager.initiateDatabase([
      TodoCacheTable(),
      TodoSavedTable(),
      UserTable(),
    ]);

    UserTable user = UserTable();
    TodoSavedTable todoTable = TodoSavedTable();
    TodoCacheTable todoCacheTable = TodoCacheTable();
    user.getEventTableData().then((value) => print("user $value"));
    todoCacheTable.getEventTableData().then((value) => print("todoCacheTable $value"));
    todoTable.getEventTableData().then((value) => print("todoTable $value"));
  }
}