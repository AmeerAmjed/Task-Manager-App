import 'package:sqflite/sqlite_api.dart';
import 'package:task_manager/data/local/database_manager.dart';
import 'package:task_manager/data/local/entity/user_entity.dart';

const String _userTable = 'userTable';

class UserTable extends DatabaseManager<UserEntity> {
  @override
  String tableName = _userTable;

  @override
  Future<void> createTable(Batch batch) async {
    batch.execute('''
      CREATE TABLE $tableName (
                    $id INTEGER PRIMARY KEY NOT NULL,
                    $userId INTEGER NOT NULL,
                    $email STRING NOT NULL,
                    $username STRING NOT NULL,
                    $firstName STRING NOT NULL,
                    $lastName STRING NOT NULL,
                    $gender STRING NOT NULL,
                    $avatar STRING NOT NULL)
              ''');
  }
}
