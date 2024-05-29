part of 'create_todo_bloc.dart';

abstract class CreateTodoEvent extends Equatable {
  const CreateTodoEvent();

  @override
  List<Object> get props => [];
}

@immutable
class SubmittedCreateTodoEvent extends CreateTodoEvent {}
