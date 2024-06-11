import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/ui/route/app_route.dart';
import 'package:task_manager/ui/theme/theme.dart';
import 'package:task_manager/ui/views/create_todo/bloc/create_todo_bloc.dart';

class ToDoApp extends StatelessWidget with AppRouter {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CreateTodoBloc>(
          lazy: true,
          create: (BuildContext context) => getIt.get<CreateTodoBloc>(),
        ),
      ],
      child: MaterialApp.router(
        routeInformationProvider: AppRouter.router.routeInformationProvider,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routerDelegate: AppRouter.router.routerDelegate,
        debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeApp().light,
      darkTheme: ThemeApp().dark,
      ),
    );
  }
}
