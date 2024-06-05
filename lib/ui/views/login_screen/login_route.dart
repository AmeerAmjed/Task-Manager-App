import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/ui/views/login_screen/bloc/login_screen_bloc.dart';
import 'package:task_manager/ui/views/login_screen/login_screen.dart';

const _route = "/login";

final loginRoute = GoRoute(
  path: _route,
  builder: (context, state) => BlocProvider(
    create: (context) => getIt<LoginScreenBloc>(),
    child: const LoginScreen(),
  ),
);
