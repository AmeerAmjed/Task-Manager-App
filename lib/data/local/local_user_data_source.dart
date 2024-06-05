import 'package:task_manager/data/local/entity/user_entity.dart';
import 'package:task_manager/data/local/table/user_table.dart';

abstract class UserLocalDataSource {
  saveUser(UserEntity user);

  Future<UserEntity?> getUser();

  Future<int> getUserId();
}

class UserLocalDataSourceImpl extends UserTable implements UserLocalDataSource {
  final int userIdLocal = 0;
  @override
  saveUser(UserEntity user) {
    insert(user);
  }

  @override
  Future<UserEntity?> getUser() {
    return queryById(userIdLocal).then((value) {
      if (value.first.isNotEmpty) return UserEntity.fromJson(value.first);
      return null;
    });
  }

  @override
  Future<int> getUserId() {
    return queryById(userIdLocal).then((value) {
      return UserEntity.fromJson(value.first).id;
    });
  }
}
