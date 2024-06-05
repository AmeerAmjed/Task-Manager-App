import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/domain/repository/authentication_repository.dart';
import 'package:task_manager/ui/views/home_screen/home_route.dart';
import 'package:task_manager/ui/views/login_screen/login_route.dart';
import 'package:task_manager/ui/views/todos_saved_screen/todos_saved_route.dart';

mixin class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      loginRoute,
      homeRoute,
      todosSavedRoute,
    ],
    redirect: (BuildContext context, GoRouterState state) async {
      bool isLogin = await getIt.get<AuthenticationRepository>().isUserLogin();
      if (isLogin) return homeRoute.path;

      return loginRoute.path;
    },
  );

  static GoRouter get router => _router;
}
