import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/ui/views/home_screen/bloc/home_screen_bloc.dart';
import 'package:task_manager/ui/views/home_screen/home_screen.dart';

const _route = "/home";

final homeRoute = GoRoute(
  path: _route,
  builder: (context, state) => BlocProvider(
    create: (context) => getIt<HomeScreenBloc>(),
    child: const HomeScreen(),
  ),
);
