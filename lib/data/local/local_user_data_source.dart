import 'package:task_manager/data/local/entity/user_entity.dart';
import 'package:task_manager/data/local/table/user_table.dart';

abstract class UserLocalDataSource {
  saveUser(UserEntity user);

  Future<UserEntity> getUser();
}

class UserLocalDataSourceImpl extends UserTable implements UserLocalDataSource {
  final int userIdLocal = 0;
  @override
  saveUser(UserEntity user) {
    insert(user);
  }

  @override
  Future<UserEntity> getUser() {
    return queryById(userIdLocal).then((value) {
      return  UserEntity.fromJson(value.first);
    });
  }
}
