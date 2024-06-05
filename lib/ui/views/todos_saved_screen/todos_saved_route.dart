import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/ui/views/todos_saved_screen/bloc/todos_saved_screen_bloc.dart';
import 'package:task_manager/ui/views/todos_saved_screen/todos_saved_screen.dart';

const _route = "/todoSaved";

final todosSavedRoute = GoRoute(
  path: _route,
  builder: (context, state) => BlocProvider(
    create: (context) => getIt<TodosSavedScreenBloc>(),
    child: const TodosSavedScreen(),
  ),
);
