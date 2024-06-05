part of 'get_it.dart';

void setupDataModule() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  // getIt.registerLazySingleton<UserTable>(() => UserTable());
  // getIt.registerLazySingleton<TodoTable>(() => TodoTable());
  getIt.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl());

  getIt.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      getIt.get<FlutterSecureStorage>(),
      authentication: ApiAuthenticationServiceImpl(
        client: getIt.get<Dio>(),
      ),
      userLocalDataSource: getIt.get<UserLocalDataSource>(),
    ),
  );

  getIt.registerLazySingleton<LocalTodoDataSource>(
    () => LocalTodoDataSourceImpl(),
  );

  getIt.registerLazySingleton<LocalTodosCacheDataSource>(
    () => LocalTodosCacheDataSourceImpl(),
  );

  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ),
  );

  getIt.registerLazySingleton<ApiAuthenticationService>(
    () => ApiAuthenticationServiceImpl(client: getIt.get<Dio>()),
  );

  getIt.registerLazySingleton<LocalSecureDataSource>(
    () => LocalSecureDataSourceImpl(getIt.get<FlutterSecureStorage>()),
  );
}
