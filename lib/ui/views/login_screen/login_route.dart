import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/ui/route/app_route.dart';
import 'package:task_manager/ui/views/login_screen/bloc/login_screen_bloc.dart';
import 'package:task_manager/ui/views/login_screen/login_screen.dart';
import 'package:task_manager/ui/widget/build_page_with_fade_transition.dart';

const _route = "/login";

final loginRoute = GoRoute(
  path: _route,
  pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
    context: context,
    state: state,
    child: BlocProvider(
      create: (context) => getIt<LoginScreenBloc>(),
      child: const LoginScreen(),
    ),
  ),
);
