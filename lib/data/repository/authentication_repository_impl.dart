import 'package:task_manager/data/remote/api_authentication_service.dart';
import 'package:task_manager/data/remote/mapper/to_user_model.dart';
import 'package:task_manager/domain/model/user_model.dart';
import 'package:task_manager/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final ApiAuthenticationService authentication;

  AuthenticationRepositoryImpl(this.authentication);

  @override
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    return await authentication
        .login(username: username, password: password)
        .then((user) {
      print("object $user");
      return user.toUserModel();
    });
  }
}
