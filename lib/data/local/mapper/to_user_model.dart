import 'package:task_manager/data/local/entity/user_entity.dart';
import 'package:task_manager/domain/model/user_model.dart';

extension ToUserModelExtension on UserEntity {
  UserModel toUserModel() {
    return UserModel(
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
