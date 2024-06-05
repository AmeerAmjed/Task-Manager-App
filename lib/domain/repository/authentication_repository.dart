import 'package:task_manager/domain/model/user_model.dart';

abstract class AuthenticationRepository {
  Future<UserModel> login({required String username, required String password});

  Future<UserModel?> getUser();
}
