import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_manager/domain/model/todo_model.dart';
import 'package:task_manager/ui/views/home_screen/bloc/home_screen_bloc.dart';
import 'package:task_manager/ui/views/home_screen/widget/item_todo.dart';
import 'package:task_manager/ui/widget/error_view.dart';

class TodosView extends StatelessWidget {
  const TodosView({
    super.key,
    required this.state,
  });

  final HomeScreenState state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ListView.builder(
        controller: context.read<HomeScreenBloc>().scrollController,
        itemCount: context.read<HomeScreenBloc>().todo.length +
            (!context.read<HomeScreenBloc>().isLastItem ? 0 : 1),
        itemBuilder: (BuildContext context, int index) {
          if (index == context.read<HomeScreenBloc>().todo.length - 1) {
            if (state is LoadingState) {
              return const ShimmerItemTodo();
            } else if (state is ErrorState) {
              return ErrorView(
                message: (state as ErrorState).message,
                onPressed: () {},
              );
            }
          }

          final todo = context.read<HomeScreenBloc>().todo[index];
          return ItemTodo(
            todo: todo,
            onPressed: () {
              context.read<HomeScreenBloc>().add(SaveTodo(todo: todo));
            },
          );
        },
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}

class ShimmerTodosView extends StatelessWidget {
  const ShimmerTodosView({super.key, this.itemCountToShow = 10});

  final int itemCountToShow;

  @override
  Widget build(BuildContext context) {
    var todo = ItemTodo(
      todo: TodoModel(
        id: 1,
        userId: 1,
        title: "",
        isCompleted: true,
      ),
    );
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: ListView.builder(
        itemCount: itemCountToShow, // Number of shimmer placeholders
        itemBuilder: (context, index) {
          return todo;
        },
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}