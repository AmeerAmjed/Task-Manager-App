import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/DatabaseInitializer.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/ui/route/app_route.dart';
import 'package:task_manager/ui/theme/theme.dart';
import 'package:task_manager/ui/views/create_todo/bloc/create_todo_bloc.dart';
import 'package:task_manager/ui/views/home_screen/bloc/home_screen_bloc.dart';
import 'package:task_manager/ui/views/home_screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  await DatabaseInitializer.initialize();

  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget with AppRouter {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeScreenBloc>(
          create: (BuildContext context) =>
              HomeScreenBloc()..add(GetDataEvent()),
        ),
        BlocProvider<CreateTodoBloc>(
          lazy: true,
          create: (BuildContext context) => CreateTodoBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Task Manager',
        theme: ThemeApp().light,
        darkTheme: ThemeApp().dark,
        home: const HomeScreen(),
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
