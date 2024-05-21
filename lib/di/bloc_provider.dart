import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/ui/views/home_screen/bloc/home_screen_bloc.dart';
import 'package:task_manager/ui/views/login_screen/bloc/login_screen_bloc.dart';

void setupBlocProvider() {
  getIt.registerLazySingleton<HomeScreenBloc>(
    () => HomeScreenBloc()..add(GetTodosEvent()),
  );

  getIt.registerLazySingleton<LoginScreenBloc>(
    () => LoginScreenBloc(),
  );
}
