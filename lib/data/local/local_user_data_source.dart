import 'package:task_manager/data/local/entity/user_entity.dart';
import 'package:task_manager/data/local/table/user_table.dart';

abstract class UserLocalDataSource {
  saveUser(UserEntity user);

  Future<UserEntity> getUser();
}

class UserLocalDataSourceImpl extends UserTable implements UserLocalDataSource {
  @override
  saveUser(UserEntity user) {
    insert(user);
  }

  @override
  Future<UserEntity> getUser() {
    return queryById(1).then((value){

      print("ameer $value");
      return  UserEntity.fromJson(value.first);
    });
  }
}
