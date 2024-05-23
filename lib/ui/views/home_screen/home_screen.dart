import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/ui/route/routes_screen.dart';
import 'package:task_manager/ui/views/home_screen/bloc/home_screen_bloc.dart';
import 'package:task_manager/ui/views/home_screen/widget/home_app_bar.dart';
import 'package:task_manager/ui/views/home_screen/widget/todos_view.dart';
import 'package:task_manager/ui/widget/error_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        onClickSavedAction: () {
          Navigator.pushNamed(context, RoutesScreen.todoSaved);
        },
      ),
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
          builder: (BuildContext context, state) {
        if (context.read<HomeScreenBloc>().todo.isEmpty) {
          if (state is LoadingState) {
            return const ShimmerTodosView();
          } else if (state is ErrorState) {
            return ErrorView(
              message: state.message,
              onPressed: () {},
            );
          }
        }
            return TodosView(
          state: state,
        );
      }),
    );
  }
}
