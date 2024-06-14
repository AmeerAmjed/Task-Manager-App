part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  List<Object?> get props => [];
}

class GetTodosEvent extends HomeScreenEvent {}

class CheckMoreTodoRequiredEvent extends HomeScreenEvent {
  const CheckMoreTodoRequiredEvent();
}

class SaveTodoEvent extends HomeScreenEvent {
  final TodoModel todo;
  const SaveTodoEvent({required this.todo});

  List<Object?> get props => [todo];
}

class DeleteTodo extends HomeScreenEvent {
  final int todoId;

  const DeleteTodo({required this.todoId});

  List<Object?> get props => [todoId];
}

class OnChangedItemTodoCompletedEvent extends HomeScreenEvent {
  final int todoId;
  final bool? isCompleted;

  const OnChangedItemTodoCompletedEvent({
    required this.todoId,
    required this.isCompleted,
  });

  List<Object?> get props => [todoId, isCompleted];
}

class ResetToastEvent extends HomeScreenEvent {}