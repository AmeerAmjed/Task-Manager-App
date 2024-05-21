import 'package:task_manager/data/local/local_user_data_source.dart';
import 'package:task_manager/data/local/mapper/to_user_entity.dart';
import 'package:task_manager/data/local/mapper/to_user_model.dart';
import 'package:task_manager/data/remote/api_authentication_service.dart';
import 'package:task_manager/data/remote/mapper/to_user_model.dart';
import 'package:task_manager/domain/model/user_model.dart';
import 'package:task_manager/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final ApiAuthenticationService authentication;
  final UserLocalDataSource userLocalDataSource;

  AuthenticationRepositoryImpl(this.authentication, this.userLocalDataSource);

  @override
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    return await authentication
        .login(username: username, password: password)
        .then((user) {
      print("object $user");
      userLocalDataSource.saveUser(user.toUserModel().toUserEntity());
      return user.toUserModel();
    });
  }

  @override
  saveUser(UserModel user) {
    userLocalDataSource.saveUser(user.toUserEntity());
  }

  @override
  Future<UserModel> getUser() {
    return userLocalDataSource.getUser().then((user) => user.toUserModel());
  }
}
