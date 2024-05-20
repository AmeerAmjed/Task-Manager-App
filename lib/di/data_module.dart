part of 'get_it.dart';

void setupDataModule() {
  getIt.registerLazySingleton<Dio>(() => Dio());
}
