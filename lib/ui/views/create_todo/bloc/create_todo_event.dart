part of 'create_todo_bloc.dart';

abstract class CreateTodoEvent extends Equatable {
  const CreateTodoEvent();

  @override
  List<Object> get props => [];
}

@immutable
class SubmittedCreateTodoEvent extends CreateTodoEvent {}

@immutable
class OnChangeIsCompleted extends CreateTodoEvent {
  final bool isCompleted;

  const OnChangeIsCompleted({required this.isCompleted});

  @override
  List<Object> get props => [isCompleted];
}
