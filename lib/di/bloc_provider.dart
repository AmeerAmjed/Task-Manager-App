import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/ui/views/create_todo/bloc/create_todo_bloc.dart';
import 'package:task_manager/ui/views/home_screen/bloc/home_screen_bloc.dart';
import 'package:task_manager/ui/views/login_screen/bloc/login_screen_bloc.dart';
import 'package:task_manager/ui/views/todos_saved_screen/bloc/todos_saved_screen_bloc.dart';

void setupBlocProvider() {
  getIt.registerLazySingleton<HomeScreenBloc>(
    () => HomeScreenBloc()..add(GetTodosEvent()),
  );

  getIt.registerLazySingleton<TodosSavedScreenBloc>(
    () => TodosSavedScreenBloc()..add(GetTodosSavedEvent()),
  );

  getIt.registerLazySingleton<LoginScreenBloc>(
    () => LoginScreenBloc(),
  );

  getIt.registerLazySingleton<CreateTodoBloc>(
    () => CreateTodoBloc(),
  );
}
