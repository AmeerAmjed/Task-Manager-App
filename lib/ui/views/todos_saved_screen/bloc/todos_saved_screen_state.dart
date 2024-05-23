part of 'todos_saved_screen_bloc.dart';

@immutable
abstract class TodosSavedScreenState extends Equatable {
  const TodosSavedScreenState();

  @override
  List<Object?> get props => [];
}

class LoadingState extends TodosSavedScreenState {}

class EmptyState extends TodosSavedScreenState {}

class SucceedGetDataState extends TodosSavedScreenState {
  final List<TodoModel> todos;

  const SucceedGetDataState(this.todos);

  @override
  List<Object?> get props => [todos];
}

class ErrorState extends TodosSavedScreenState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
