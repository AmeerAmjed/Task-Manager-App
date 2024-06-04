import 'package:task_manager/domain/repository/authentication_repository.dart';
import 'package:task_manager/domain/usecase/todo_usecase.dart';
import 'package:task_manager/domain/usecase/user_usecase.dart';

import 'get_it.dart';

void setupUsecaseModule() {
  getIt.registerLazySingleton<TodoUsease>(
    () => TodoUsease(),
  );

  getIt.registerLazySingleton<UserUsecase>(
    () => UserUsecase(
      getIt.get<AuthenticationRepository>(),
    ),
  );
}
