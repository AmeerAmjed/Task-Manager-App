part of 'home_screen_bloc.dart';

@immutable
abstract class HomeScreenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingState extends HomeScreenState {}

class SucceedGetDataState extends HomeScreenState {
  final List<TodoModel> todos;

  SucceedGetDataState(this.todos);

  @override
  List<Object?> get props => [todos];
}
class SucceedGetUserInfoState extends HomeScreenState {}
class ErrorState extends HomeScreenState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
