import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/ui/views/home_screen/widget/todos_view.dart';
import 'package:task_manager/ui/views/todos_saved_screen/bloc/todos_saved_screen_bloc.dart';
import 'package:task_manager/ui/views/todos_saved_screen/widget/empty_todo_saved.dart';
import 'package:task_manager/ui/views/todos_saved_screen/widget/todos_saved_view.dart';
import 'package:task_manager/ui/widget/bottom_sheet.dart';
import 'package:task_manager/ui/widget/error_view.dart';

class TodosSavedScreen extends StatelessWidget {
  const TodosSavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo Saved",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<TodosSavedScreenBloc, TodosSavedScreenState>(
            builder: (BuildContext context, state) {
          if (context.read<TodosSavedScreenBloc>().todos.isEmpty) {
            if (state is LoadingState) {
              return const ShimmerTodosView();
            }
            if (state is EmptyState) {
              return const EmptyTodoSaved();
            } else if (state is ErrorState) {
              return ErrorView(
                message: state.message,
                onPressed: () {},
              );
            }
          }
          return TodosSavedView(
            todos: context.read<TodosSavedScreenBloc>().todos,
              onClickMoreOptions: (int todoId) {
                bottomSheet(
                  height: 150,
                  context: context,
                  children: <Widget>[
                    ButtonActionBottomSheet(
                      title: "Remove",
                      icon: Icons.bookmark_remove,
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.read<TodosSavedScreenBloc>().add(
                              UnsavedTodoEvent(
                                todoId: todoId,
                              ),
                            );
                      },
                      paddingVertical: 4,
                    ),
                  ],
                );
              });
        }),
      ),
    );
  }
}
