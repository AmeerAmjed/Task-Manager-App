import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/ui/route/routes_screen.dart';
import 'package:task_manager/ui/views/home_screen/bloc/home_screen_bloc.dart';
import 'package:task_manager/ui/views/home_screen/widget/button_add_todo.dart';
import 'package:task_manager/ui/views/home_screen/widget/home_app_bar.dart';
import 'package:task_manager/ui/views/home_screen/widget/todos_view.dart';
import 'package:task_manager/ui/widget/bottom_sheet.dart';
import 'package:task_manager/ui/widget/error_view.dart';

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
          Navigator.pushNamed(context, RoutesScreen.todoSaved);
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
          Future(() {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Succeed delete Todo"),
              ),
            );
          });
        }

        if (state.isDeleteTodoFailed) {
          Future(() {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Failed delete Todo"),
              ),
            );
          });
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
                height: 100,
                context: context,
                children: <Widget>[
                  ButtonActionBottomSheet(
                    title: "Delete",
                    icon: Icons.delete,
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.read<HomeScreenBloc>().add(
                            DeleteTodo(
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
      floatingActionButton: const ButtonAddTodo(),
    );
  }
}
