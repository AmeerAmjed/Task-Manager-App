import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/domain/model/todo_model.dart';
import 'package:task_manager/domain/model/user_model.dart';
import 'package:task_manager/domain/usecase/todo_usecase.dart';
import 'package:task_manager/domain/usecase/user_usecase.dart';
import 'package:task_manager/utils/end_scroll.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenUiState> {
  final TodoUsease todoUsease = getIt.get<TodoUsease>();
  final UserUsecase userUsecase = getIt.get<UserUsecase>();
  final ScrollController scrollController = ScrollController();


  int itemsRetrievedCount = 0;
  int itemsPerRequest = 10;
  bool isLastItem = false;

  HomeScreenBloc() : super(const HomeScreenInitialUiState()) {
    on<HomeScreenEvent>((event, emit) async {

      },
    );

    on<GetTodosEvent>((event, emit) async {
      await _getTodos(emit);
      await _getUserInfo(emit);
    });

    on<CheckMoreTodoRequiredEvent>((event, emit) async {
      await _checkForMoreTodoRequired(event, emit);
    });

    on<SaveTodoEvent>((event, emit) async {
      await todoUsease.saveTodo(event.todo);
    });

    on<DeleteTodo>((event, emit) async {
      await _deleteTodo(event, emit);
    });

    on<OnChangedItemTodoCompletedEvent>(
      (event, emit) async {
        if (event.isCompleted != null) {
          _updateTodoIsCompleted(
            todoId: event.todoId,
            isCompleted: event.isCompleted!,
          );

          await _updateTodosState(
            todoId: event.todoId,
            isCompleted: event.isCompleted!,
            emit: emit,
          );
        }
      },
    );

    on<ResetToastEvent>((event, emit) {
      emit(state.copyWith(
        isShowToast: false,
        isDeleteTodoSuccess: false,
        isDeleteTodoFailed: false,
      ));
    });

    _scrollListener();
  }

  Future _getTodos(Emitter<HomeScreenUiState> emit) async {
    emit(state.copyWith(isLoading: true));
    print("CheckMoreTodoRequiredEvent");
    try {
      itemsRetrievedCount = state.todos.length;
      final todos = await todoUsease.getTodos(
        skip: itemsRetrievedCount,
        limit: itemsPerRequest,
      );
      print("CheckMoreTodoRequiredEvent $todos");
      print("CheckMoreTodoRequiredEvent $todos");

      if (todos.isEmpty) {
        isLastItem = true;
      }
      List<TodoModel> updatedTodos = List.from(state.todos)..addAll(todos);
      emit(
        state.copyWith(
          isLoading: false,
          isGetTodosSuccess: true,
          todos: updatedTodos,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
            isLoading: false,
            isGetTodosFailed: true,
            errorMessage: error.toString()),
      );
    }
  }

  Future _checkForMoreTodoRequired(CheckMoreTodoRequiredEvent event,
      Emitter<HomeScreenUiState> emit) async {
    if (!isLastItem) {
      add(GetTodosEvent());
    }
  }

  Future _getUserInfo(Emitter<HomeScreenUiState> emit) async {
    var user = await userUsecase.getUser();

    emit(
      state.copyWith(user: user),
    );
  }

  _scrollListener() {
    scrollController.addListener(
      () {
        if (scrollController.isEndScroll()) {
          add(const CheckMoreTodoRequiredEvent());
        }
      },
    );
  }

  Future<bool> _updateTodoIsCompleted({
    required int todoId,
    required bool isCompleted,
  }) async {
    return await todoUsease.updateTodoIsCompleted(
      todoId: todoId,
      isCompleted: isCompleted,
    );
  }

  _updateTodosState({
    required int todoId,
    required bool isCompleted,
    required Emitter<HomeScreenUiState> emit,
  }) async {
    final updatedTodos = List<TodoModel>.from(state.todos);
    final index = updatedTodos.indexWhere((todo) => todo.id == todoId);

    if (index != -1) {
      updatedTodos[index] = TodoModel(
        id: updatedTodos[index].id,
        userId: updatedTodos[index].userId,
        title: updatedTodos[index].title,
        isCompleted: isCompleted,
      );
    }

    emit(
      state.copyWith(
        todos: updatedTodos,
      ),
    );
  }

  Future _deleteTodo(DeleteTodo event, Emitter<HomeScreenUiState> emit) async {
    var result = await todoUsease.deleteTodo(event.todoId);
    if (result) {
      emit(
        state.copyWith(
          isShowToast: true,
          isDeleteTodoSuccess: true,
          todos: _removeTodoById(event.todoId),
        ),
      );
    } else {
      emit(state.copyWith(
        isShowToast: true,
        isDeleteTodoFailed: true,
      ));
    }
  }

  List<TodoModel> _removeTodoById(int todoId) {
    final updatedTodos = List<TodoModel>.from(state.todos);
    updatedTodos.removeWhere((todo) => todo.id == todoId);
    return updatedTodos;
  }
}
