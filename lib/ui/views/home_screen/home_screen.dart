import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/ui/views/home_screen/bloc/home_screen_bloc.dart';
import 'package:task_manager/ui/views/home_screen/widget/button_add_todo.dart';
import 'package:task_manager/ui/views/home_screen/widget/home_app_bar.dart';
import 'package:task_manager/ui/views/home_screen/widget/todos_view.dart';
import 'package:task_manager/ui/views/todos_saved_screen/todos_saved_route.dart';
import 'package:task_manager/ui/widget/bottom_sheet.dart';
import 'package:task_manager/ui/widget/error_view.dart';
import 'package:task_manager/ui/widget/toast.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: HomeAppBar(
        onClickSavedAction: () {
          context.push(todosSavedRoute.path);
        },
      ),
      body: BlocBuilder<HomeScreenBloc, HomeScreenUiState>(
          builder: (BuildContext context, state) {
        if (state.todos.isEmpty) {
          if (state.isLoading) {
            return const ShimmerTodosView();
          } else if (state.isGetTodosFailed && state.errorMessage != null) {
            return ErrorView(
              message: state.errorMessage!,
              onPressed: () {},
            );
          }
        }

        if (state.isDeleteTodoSuccess) {
          toast(
            "Succeed delete Todo",
            backgroundColor: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.onPrimary,
          );
        }

        if (state.isDeleteTodoFailed) {
          toast(
            state.errorMessage ?? "",
            backgroundColor: Theme.of(context).colorScheme.error,
            textColor: Theme.of(context).colorScheme.onError,
          );
        }

        return TodosView(
            state: state,
            onChangedItemTodoCompleted: (int todoId, bool? value) {
              context.read<HomeScreenBloc>().add(
                    OnChangedItemTodoCompletedEvent(
                      todoId: todoId,
                      isCompleted: value,
                    ),
                  );
            },
            onClickMoreOptions: (todoId) {
              bottomSheet(
                heightFactor: 17,
                context: context,
                children: <Widget>[
                  ButtonActionBottomSheet(
                    title: "Save",
                    icon: Icons.bookmark,
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.read<HomeScreenBloc>().add(
                            SaveTodoEvent(
                              todo: todoId,
                            ),
                          );
                    },
                    paddingVertical: 4,
                  ),
                  ButtonActionBottomSheet(
                    title: "Delete",
                    icon: Icons.delete,
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.read<HomeScreenBloc>().add(
                            DeleteTodo(
                              todoId: todoId.id,
                            ),
                          );
                    },
                    paddingVertical: 4,
                  ),
                ],
              );
            });
      }),
      floatingActionButton: const ButtonAddTodo(),
    );
  }
}
