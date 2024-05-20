import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/ui/route/app_pages.dart';
import 'package:task_manager/ui/route/app_routes.dart';
import 'package:task_manager/ui/views/login_screen/bloc/login_screen_bloc.dart';
import 'package:task_manager/ui/views/login_screen/login_screen.dart';

final loginPage = PageEntity(
  route: AppRoutes.login,
  page: const LoginScreen(),
  bloc: BlocProvider(
    create: (_) => LoginScreenBloc(),
  ),
);
