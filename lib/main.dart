import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/domain/usecase/todo_usecase.dart';
import 'package:task_manager/ui/theme/theme.dart';
import 'package:task_manager/ui/views/home_screen/bloc/home_screen_bloc.dart';
import 'package:task_manager/ui/views/home_screen/home_screen.dart';

void main() {
  setupGetIt();
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeScreenBloc(todoUsease: TodoUsease())..add(GetTodosEvent()),
      child: MaterialApp(
        title: 'Task Manager',
        theme: ThemeApp().light,
        home: const HomeScreen(),
      ),
    );
  }
}
