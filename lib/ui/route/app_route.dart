import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/ui/route/routes_screen.dart';
import 'package:task_manager/ui/views/home_screen/bloc/home_screen_bloc.dart';
import 'package:task_manager/ui/views/home_screen/home_screen.dart';
import 'package:task_manager/ui/views/login_screen/login_screen.dart';
import 'package:task_manager/ui/views/todos_saved_screen/bloc/todos_saved_screen_bloc.dart';
import 'package:task_manager/ui/views/todos_saved_screen/todos_saved_screen.dart';

mixin class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesScreen.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt.get<HomeScreenBloc>(),
            child: const HomeScreen(),
          ),
        );
      case RoutesScreen.todoSaved:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt.get<TodosSavedScreenBloc>(),
            child: const TodosSavedScreen(),
          ),
        );
      case RoutesScreen.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt.get<HomeScreenBloc>(),
            child: const LoginScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt.get<HomeScreenBloc>(),
            child: const LoginScreen(),
          ),
        );
    }
  }
}
