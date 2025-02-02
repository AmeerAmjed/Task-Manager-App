import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/domain/model/todo_model.dart';
import 'package:task_manager/domain/usecase/todo_usecase.dart';

part 'todos_saved_screen_event.dart';
part 'todos_saved_screen_state.dart';

class TodosSavedScreenBloc
    extends Bloc<TodosSavedScreenEvent, TodosSavedScreenUiState> {
  final TodoUsease todoUsease = getIt.get<TodoUsease>();

  TodosSavedScreenBloc() : super(TodosSavedScreenInitialState()) {
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
    Emitter<TodosSavedScreenUiState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final todos = await todoUsease.getTodosSaved();

      if (todos.isNotEmpty) {
        emit(state.copyWith(
          isLoading: false,
          isGetTodosSuccess: false,
          todos: todos,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          isEmpty: true,
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        isGetTodosFailed: true,
        errorMessage: error.toString(),
      ));
    }
  }

  Future _unSaveTodo(
    UnsavedTodoEvent event,
    Emitter<TodosSavedScreenUiState> emit,
  ) async {
    await todoUsease.unSaveTodo(event.todoId);
    _removeTodoById(event.todoId, emit);
  }

  void _removeTodoById(
    int todoId,
    Emitter<TodosSavedScreenUiState> emit,
  ) {
    final updatedTodos = List<TodoModel>.from(state.todos);
    updatedTodos.removeWhere((todo) => todo.id == todoId);
    emit(
      state.copyWith(
        todos: updatedTodos,
        isEmpty: updatedTodos.isEmpty,
      ),
    );
  }
}
