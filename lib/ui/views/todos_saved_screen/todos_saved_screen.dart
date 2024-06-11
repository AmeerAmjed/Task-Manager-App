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
    final bloc = context.read<TodosSavedScreenBloc>();

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
        child: BlocBuilder<TodosSavedScreenBloc, TodosSavedScreenUiState>(
            builder: (BuildContext context, state) {
          if (state.todos.isEmpty) {
            if (state.isLoading) {
              return const ShimmerTodosView();
            }
            if (state.isEmpty) {
              return const EmptyTodoSaved();
            } else if (state.isGetTodosFailed) {
              return ErrorView(
                message: state.errorMessage ?? "",
                onPressed: () {},
              );
            }
          }
          return TodosSavedView(
              todos: state.todos,
              onClickMoreOptions: (int todoId) {
                bottomSheet(
                  heightFactor: 14,
                  context: context,
                  children: <Widget>[
                    ButtonActionBottomSheet(
                      title: "UnSave",
                      icon: Icons.bookmark_remove,
                      onPressed: () {
                        Navigator.of(context).pop();
                        bloc.add(
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
