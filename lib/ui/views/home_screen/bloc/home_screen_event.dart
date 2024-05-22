part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  List<Object?> get props => [];
}

class GetTodosEvent extends HomeScreenEvent {}

class CheckMoreTodoRequiredEvent extends HomeScreenEvent {
  const CheckMoreTodoRequiredEvent();
}

class SaveTodo extends HomeScreenEvent {
  final TodoModel todo;
  const SaveTodo({required this.todo});

  List<Object?> get props => [todo];
}