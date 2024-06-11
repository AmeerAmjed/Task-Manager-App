import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/domain/usecase/todo_usecase.dart';
import 'package:task_manager/ui/utils/input_validation.dart';

part 'create_todo_event.dart';
part 'create_todo_state.dart';

class CreateTodoBloc extends Bloc<CreateTodoEvent, CreateTodoUiState>
    with InputValidation {
  final TodoUsease _todoUsease = getIt.get<TodoUsease>();

  CreateTodoBloc() : super(const CreateTodoInitialState()) {
    on<CreateTodoEvent>((event, emit) async {
      if (event is SubmittedCreateTodoEvent) {
        await _onSubmitted(emit);
      }
    });

    on<OnChangeIsCompleted>((event, emit) async {
      emit(state.copyWith(isCompleted: event.isCompleted));
    });
  }

  Future _onSubmitted(Emitter<CreateTodoUiState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final response = await _todoUsease.createTodo(
        title: state.todo.trim(),
        isCompleted: state.isCompleted,
      );
      if (response) {
        emit(
          state.copyWith(
            isLoading: false,
            isCreateTodoSuccess: true,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            isCreateTodoSuccess: false,
            isCreateTodoFailed: true,
            errorMessage: "error",
          ),
        );
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isCreateTodoSuccess: false,
          isCreateTodoFailed: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
