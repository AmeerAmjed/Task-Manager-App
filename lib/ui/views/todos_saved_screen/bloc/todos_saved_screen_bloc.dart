import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/domain/model/todo_model.dart';
import 'package:task_manager/domain/usecase/todo_usecase.dart';

part 'todos_saved_screen_event.dart';
part 'todos_saved_screen_state.dart';

class TodosSavedScreenBloc
    extends Bloc<TodosSavedScreenEvent, TodosSavedScreenState> {
  final TodoUsease todoUsease = getIt.get<TodoUsease>();

  final List<TodoModel> _todos = [];

  List<TodoModel> get todos => _todos;

  TodosSavedScreenBloc() : super(LoadingState()) {
    on<TodosSavedScreenEvent>((event, emit) async {
      if (event is GetTodosSavedEvent) {
        await _getTodos(event, emit);
      }
    });

    on<UnsavedTodoEvent>((event, emit) async {
      await _unSaveTodo(event, emit);
    });
  }

  Future _getTodos(
    GetTodosSavedEvent event,
    Emitter<TodosSavedScreenState> emit,
  ) async {
    emit(LoadingState());
    try {
      final resultTodos = await todoUsease.getTodosSaved();

      if (resultTodos.isNotEmpty) {
        todos.addAll(resultTodos);
        emit(SucceedGetDataState(todos));
      } else {
        emit(EmptyState());
      }
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

  Future _unSaveTodo(
    UnsavedTodoEvent event,
    Emitter<TodosSavedScreenState> emit,
  ) async {
    await todoUsease.unSaveTodo(event.todoId);
  }


}
