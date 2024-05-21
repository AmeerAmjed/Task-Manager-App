part of 'get_it.dart';

void setupDataModule() {
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      ApiAuthenticationServiceImpl(
        client: getIt.get<Dio>(),
      ),
    ),
  );
}
