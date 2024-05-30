part of 'create_todo_bloc.dart';

abstract class CreateTodoState extends Equatable {
  const CreateTodoState();
  
  @override
  List<Object> get props => [];
}

@immutable
class CreateTodoInitial extends CreateTodoState {}

@immutable
class LoadingUploadTodo extends CreateTodoState {}

@immutable
class IsCreateTodoSuccess extends CreateTodoState {}

@immutable
class CheckBoxCompletedState extends CreateTodoState {
  final bool isCompleted;

  const CheckBoxCompletedState({required this.isCompleted});

  @override
  List<Object> get props => [isCompleted];
}

@immutable
class IsCreateTodoFailed extends CreateTodoState {
  final String message;

  const IsCreateTodoFailed(this.message);

  @override
  List<Object> get props => [message];
}
