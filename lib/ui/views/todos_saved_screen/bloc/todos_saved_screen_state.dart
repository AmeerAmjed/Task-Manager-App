part of 'todos_saved_screen_bloc.dart';

@immutable
class TodosSavedScreenUiState extends Equatable {
  const TodosSavedScreenUiState({
    this.errorMessage,
    required this.todos,
    required this.isLoading,
    required this.isEmpty,
    required this.isGetTodosSuccess,
    required this.isGetTodosFailed,
  });

  final List<TodoModel> todos;
  final bool isLoading;
  final bool isEmpty;
  final bool isGetTodosSuccess;
  final bool isGetTodosFailed;

  final String? errorMessage;

  TodosSavedScreenUiState copyWith({
    List<TodoModel>? todos,
    bool? isLoading,
    bool? isEmpty,
    bool? isGetTodosSuccess,
    bool? isGetTodosFailed,
    String? errorMessage,
  }) {
    return TodosSavedScreenUiState(
      todos: todos ?? this.todos,
      isLoading: isLoading ?? this.isLoading,
      isEmpty: isEmpty ?? this.isEmpty,
      isGetTodosSuccess: isGetTodosSuccess ?? this.isGetTodosSuccess,
      isGetTodosFailed: isGetTodosFailed ?? this.isGetTodosFailed,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        todos,
        isLoading,
        isEmpty,
        isGetTodosSuccess,
        isGetTodosFailed,
      ];
}


class TodosSavedScreenInitialState extends TodosSavedScreenUiState {
  TodosSavedScreenInitialState()
      : super(
          todos: [],
          isLoading: false,
          isEmpty: false,
          isGetTodosSuccess: false,
          isGetTodosFailed: false,
          errorMessage: null,
        );
}

