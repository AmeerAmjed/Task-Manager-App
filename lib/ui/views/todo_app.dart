import 'package:flutter/material.dart';
import 'package:task_manager/ui/route/app_route.dart';
import 'package:task_manager/ui/theme/theme.dart';

class ToDoApp extends StatelessWidget with AppRouter {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routerDelegate: AppRouter.router.routerDelegate,
      title: 'Task Manager',
      theme: ThemeApp().light,
      darkTheme: ThemeApp().dark,
    );
  }
}
