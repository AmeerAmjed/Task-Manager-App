part of 'todos_saved_screen_bloc.dart';

abstract class TodosSavedScreenEvent extends Equatable {
  const TodosSavedScreenEvent();

  @override
  List<Object> get props => [];
}

class GetTodosSavedEvent extends TodosSavedScreenEvent {}