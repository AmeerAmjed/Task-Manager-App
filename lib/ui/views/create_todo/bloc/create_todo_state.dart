part of 'create_todo_bloc.dart';

abstract class CreateTodoState extends Equatable {
  const CreateTodoState();
  
  @override
  List<Object> get props => [];
}

class CreateTodoInitial extends CreateTodoState {}
