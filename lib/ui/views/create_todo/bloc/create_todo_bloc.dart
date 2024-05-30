import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/domain/usecase/todo_usecase.dart';
import 'package:task_manager/ui/utils/input_validation.dart';
import 'package:task_manager/utils/is_form_validated.dart';

part 'create_todo_event.dart';
part 'create_todo_state.dart';

class CreateTodoBloc extends Bloc<CreateTodoEvent, CreateTodoState>
    with InputValidation {
  final TodoUsease _todoUsease = getIt.get<TodoUsease>();

  final GlobalKey<FormState> formTitleTodoKey = GlobalKey<FormState>();
  final TextEditingController todoTitle = TextEditingController();

  bool _isCompleted = false;

  bool get isCompleted => _isCompleted;

  CreateTodoBloc() : super(CreateTodoInitial()) {
    on<CreateTodoEvent>((event, emit) async {
      if (event is SubmittedCreateTodoEvent) {
        await _onSubmitted(emit);
      }
    });

    on<OnChangeIsCompleted>((event, emit) async {
      _isCompleted = event.isCompleted;
      emit(CheckBoxCompletedState(isCompleted: _isCompleted));
    });
  }

  Future _onSubmitted(Emitter<CreateTodoState> emit) async {
    if (formTitleTodoKey.isFormValidated()) {
      emit(LoadingUploadTodo());
      try {
        final response = await _todoUsease.createTodo(
          title: todoTitle.text.trim(),
          isCompleted: _isCompleted,
        );
        if (response) {
          emit(IsCreateTodoSuccess());
        } else {
          emit(const IsCreateTodoFailed("error"));
        }
      } on Exception catch (e) {
        emit(const IsCreateTodoFailed("error"));
      }
    }
  }

  @override
  Future<void> close() {
    todoTitle.dispose();
    return super.close();
  }
}
