import 'package:dio/dio.dart';
import 'package:task_manager/data/remote/api_authentication_service.dart';
import 'package:task_manager/data/repository/authentication_repository_impl.dart';
import 'package:task_manager/domain/usecase/authentication_usecase.dart';

import 'get_it.dart';

void setupUsecaseModule() {
  getIt.registerLazySingleton<TodoUsease>(
    () => TodoUsease(),
  );

  getIt.registerLazySingleton<UserUsecase>(
    () => UserUsecase(
      AuthenticationRepositoryImpl(
        ApiAuthenticationServiceImpl(
          client: getIt.get<Dio>(),
        ),
      ),
    ),
  );
}
