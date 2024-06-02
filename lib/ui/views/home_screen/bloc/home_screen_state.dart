part of 'home_screen_bloc.dart';

@immutable
class HomeScreenUiState extends Equatable {
  const HomeScreenUiState({
    this.user,
    this.errorMessage,
    required this.todos,
    required this.isLoading,
    required this.isGetTodosSuccess,
    required this.isGetTodosFailed,
    required this.isDeleteTodoSuccess,
    required this.isDeleteTodoFailed,
  });

  final List<TodoModel> todos;

  final UserModel? user;

  final bool isLoading;
  final bool isGetTodosSuccess;
  final bool isGetTodosFailed;

  final bool isDeleteTodoSuccess;
  final bool isDeleteTodoFailed;

  final String? errorMessage;

  HomeScreenUiState copyWith({
    List<TodoModel>? todos,
    UserModel? user,
    bool? isLoading,
    bool? isGetTodosSuccess,
    bool? isGetTodosFailed,
    bool? isDeleteTodoSuccess,
    bool? isDeleteTodoFailed,
    String? errorMessage,
  }) {
    return HomeScreenUiState(
      todos: todos ?? this.todos,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isGetTodosSuccess: isGetTodosSuccess ?? this.isGetTodosSuccess,
      isGetTodosFailed: isGetTodosFailed ?? this.isGetTodosFailed,
      isDeleteTodoSuccess: isDeleteTodoSuccess ?? this.isDeleteTodoSuccess,
      isDeleteTodoFailed: isDeleteTodoFailed ?? this.isDeleteTodoFailed,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        todos,
        user,
        isLoading,
        isGetTodosSuccess,
        isGetTodosFailed,
        isDeleteTodoSuccess,
        isDeleteTodoFailed,
        errorMessage,
      ];
}

class HomeScreenInitialUiState extends HomeScreenUiState {
  const HomeScreenInitialUiState()
      : super(
          todos: const [],
          user: null,
          isLoading: true,
          isGetTodosSuccess: false,
          isGetTodosFailed: false,
          isDeleteTodoSuccess: false,
          isDeleteTodoFailed: false,
          errorMessage: null,
        );
}
