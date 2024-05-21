import 'package:task_manager/data/local/entity/user_entity.dart';
import 'package:task_manager/domain/model/user_model.dart';

extension ToUserEntityModelExtension on UserModel {
  UserEntity toUserEntity() {
    return UserEntity(
      id: 0,
      userId: userId,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      avatar: avatar,
    );
  }
}
