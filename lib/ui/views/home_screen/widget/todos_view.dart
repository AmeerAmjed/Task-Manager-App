import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/ui/views/home_screen/bloc/home_screen_bloc.dart';
import 'package:task_manager/ui/views/home_screen/widget/item_todo.dart';
import 'package:task_manager/ui/widget/error_view.dart';
import 'package:task_manager/ui/widget/loading.dart';

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
              return const Loading();
            } else if (state is ErrorState) {
              return ErrorView(
                message: (state as ErrorState).message,
                onPressed: () {},
              );
            }
          }

          return ItemTodo(todo: context.read<HomeScreenBloc>().todo[index]);
        },
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
