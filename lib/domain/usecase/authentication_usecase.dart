import 'package:task_manager/domain/repository/authentication_repository.dart';

class AuthenticationUsecase {
  final AuthenticationRepository _repo;

  AuthenticationUsecase(this._repo);

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    return await _repo
        .login(username: username, password: password)
        .then((value) => true);
  }
}
