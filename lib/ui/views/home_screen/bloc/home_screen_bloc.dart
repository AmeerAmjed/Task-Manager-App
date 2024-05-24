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

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final TodoUsease todoUsease = getIt.get<TodoUsease>();
  final UserUsecase userUsecase = getIt.get<UserUsecase>();
  final ScrollController scrollController = ScrollController();

  List<TodoModel> todo = [];

  UserModel? _user;

  UserModel? get user => _user;

  int itemsRetrievedCount = 0;
  int itemsPerRequest = 10;
  bool isLastItem = false;

  HomeScreenBloc() : super(LoadingState()) {

    on<HomeScreenEvent>((event, emit) async {
      if (event is GetDataEvent) {
        await _getTodos(emit);
        await _getUserInfo(emit);
      }
      if (event is GetTodosEvent) {
        await _getTodos(emit);
      }
      if (event is CheckMoreTodoRequiredEvent) {
        await _checkForMoreTodoRequired(event, emit);
      }

      if (event is SaveTodo) {
        await todoUsease.saveTodo(event.todo) ;
      }

      if (event is DeleteTodo) {
        await _deleteTodo(event, emit);
      }
    });

    _scrollListener();
  }

  Future _getTodos(Emitter<HomeScreenState> emit) async {
    emit(LoadingState());
    try {
      itemsRetrievedCount = todo.length;
      final todos = await todoUsease.getTodos(
        skip: itemsRetrievedCount,
        limit: itemsPerRequest,
      );

      if (todos.isNotEmpty) {
        todo.addAll(todos);
      } else {
        isLastItem = true;
      }

      emit(SucceedGetDataState(todos));
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

  Future _checkForMoreTodoRequired(
      CheckMoreTodoRequiredEvent event, Emitter<HomeScreenState> emit) async {
    if (!isLastItem) {
      add(GetTodosEvent());
    }
  }

  Future _getUserInfo(Emitter<HomeScreenState> emit) async {
    await userUsecase.getUser().then((user) {
      _user = user;
    });
    emit(SucceedGetUserInfoState());
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

  Future _deleteTodo(DeleteTodo event, Emitter<HomeScreenState> emit) async {
    var result = await todoUsease.deleteTodo(event.todoId);
    result ? emit(SucceedDeleteTodoState()) : emit(FailedDeleteTodoState());
  }
}
