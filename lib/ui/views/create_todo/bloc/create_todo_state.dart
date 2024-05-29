part of 'create_todo_bloc.dart';

abstract class CreateTodoState extends Equatable {
  const CreateTodoState();
  
  @override
  List<Object> get props => [];
}

class CreateTodoInitial extends CreateTodoState {}

@immutable
class LoadingUploadTodo extends CreateTodoState {}

@immutable
class IsCreateTodoSuccess extends CreateTodoState {}

class IsCreateTodoFailed extends CreateTodoState {
  final String message;

  const IsCreateTodoFailed(this.message);

  @override
  List<Object> get props => [message];
}
