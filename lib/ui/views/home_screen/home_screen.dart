import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/ui/views/home_screen/bloc/home_screen_bloc.dart';
import 'package:task_manager/ui/views/home_screen/widget/todos_view.dart';
import 'package:task_manager/ui/widget/error_view.dart';
import 'package:task_manager/ui/widget/loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
          builder: (BuildContext context, state) {
        if (state is LoadingState) {
          return const Loading();
        }
        if (state is SucceedGetDataState) {
          return TodosView(
            todos: state.todos,
          );
        }

        if (state is ErrorState) {
          return ErrorView(
            message: state.message,
            onPressed: () {},
          );
        }
        return Container();
      }),
    );
  }
}
