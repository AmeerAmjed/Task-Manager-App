import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/domain/model/todo_model.dart';
import 'package:task_manager/domain/usecase/todo_usecase.dart';
import 'package:task_manager/domain/usecase/user_usecase.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final TodoUsease todoUsease = getIt.get<TodoUsease>();

  HomeScreenBloc() : super(LoadingState()) {
    on<HomeScreenEvent>((event, emit) async {
      if (event is GetTodosEvent) {
        emit(LoadingState());
        try {
          final todos = await todoUsease.getTodos();
          emit(SucceedGetDataState(todos));
        } catch (error) {
          emit(ErrorState(error.toString()));
        }
      }
    });
  }
}
