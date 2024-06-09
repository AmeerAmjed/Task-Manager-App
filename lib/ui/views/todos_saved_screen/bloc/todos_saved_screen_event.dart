part of 'todos_saved_screen_bloc.dart';

abstract class TodosSavedScreenEvent extends Equatable {
  const TodosSavedScreenEvent();

  @override
  List<Object> get props => [];
}

class GetTodosSavedEvent extends TodosSavedScreenEvent {}

class UnsavedTodoEvent extends TodosSavedScreenEvent {
  final int todoId;

  const UnsavedTodoEvent({required this.todoId});

  @override
  List<Object> get props => [todoId];
}

class UpdateTodosEvent extends TodosSavedScreenEvent {}