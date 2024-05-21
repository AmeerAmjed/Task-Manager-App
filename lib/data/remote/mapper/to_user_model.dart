import 'package:task_manager/data/remote/response/login_response.dart';
import 'package:task_manager/domain/model/user_model.dart';

extension UserModelExtension on LoginResponse {
  UserModel toUserModel() {
    return UserModel(
      userId: id,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      avatar: image,
    );
  }
}
