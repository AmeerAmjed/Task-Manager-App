part of 'get_it.dart';

void setupDataModule() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  // getIt.registerLazySingleton<UserTable>(() => UserTable());
  // getIt.registerLazySingleton<TodoTable>(() => TodoTable());
  getIt.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl());

  getIt.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      ApiAuthenticationServiceImpl(
        client: getIt.get<Dio>(),
      ),
      getIt.get<UserLocalDataSource>(),
    ),
  );

  getIt.registerLazySingleton<LocalTodoDataSource>(
    () => LocalTodoDataSourceImpl(),
  );

  getIt.registerLazySingleton<LocalTodosCacheDataSource>(
    () => LocalTodosCacheDataSourceImpl(),
  );
}
