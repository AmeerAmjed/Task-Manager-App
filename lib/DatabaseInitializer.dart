import 'package:task_manager/data/local/table/todo_saved_tablle.dart';
import 'package:task_manager/data/local/table/user_table.dart';
import 'package:task_manager/data/local/utils/database_manager.dart';

class DatabaseInitializer {
  static Future<void> initialize() async {
    await DatabaseManager.initiateDatabase([
      TodoSavedTable(),
      UserTable(),
    ]);

    UserTable user = UserTable();
    TodoSavedTable todoTable = TodoSavedTable();
    user.getEventTableData().then((value) => print("user $value"));
    todoTable.getEventTableData().then((value) => print("todoTable $value"));
  }
}