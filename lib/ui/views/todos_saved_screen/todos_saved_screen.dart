import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/ui/views/todos_saved_screen/bloc/todos_saved_screen_bloc.dart';

class TodosSavedScreen extends StatelessWidget {
  const TodosSavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TodosSavedScreenBloc, TodosSavedScreenState>(
          builder: (BuildContext context, state) {
        return Container();
      }),
    );
  }
}
