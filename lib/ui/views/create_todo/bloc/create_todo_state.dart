part of 'create_todo_bloc.dart';

@immutable
class CreateTodoUiState extends Equatable {
  const CreateTodoUiState({
    this.errorMessage,
    required this.todo,
    required this.isCompleted,
    required this.isLoading,
    required this.isCreateTodoSuccess,
    required this.isCreateTodoFailed,
  });

  final String todo;
  final bool isCompleted;
  final bool isLoading;
  final bool isCreateTodoSuccess;
  final bool isCreateTodoFailed;
  final String? errorMessage;

  CreateTodoUiState copyWith({
    String? todo,
    bool? isCompleted,
    bool? isLoading,
    bool? isCreateTodoSuccess,
    bool? isCreateTodoFailed,
    String? errorMessage,
  }) {
    return CreateTodoUiState(
      todo: todo ?? this.todo,
      isCompleted: isCompleted ?? this.isCompleted,
      isLoading: isLoading ?? this.isLoading,
      isCreateTodoSuccess: isCreateTodoSuccess ?? this.isCreateTodoSuccess,
      isCreateTodoFailed: isCreateTodoFailed ?? this.isCreateTodoFailed,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        todo,
        isCompleted,
        isLoading,
        isCreateTodoSuccess,
        isCreateTodoFailed,
        errorMessage,
      ];
}

@immutable
class CreateTodoInitialState extends CreateTodoUiState {
  const CreateTodoInitialState()
      : super(
          todo: '',
          isCompleted: false,
          isLoading: false,
          isCreateTodoSuccess: false,
          isCreateTodoFailed: false,
          errorMessage: null,
        );
}