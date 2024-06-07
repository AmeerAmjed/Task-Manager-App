part of 'login_screen_bloc.dart';

class LoginScreenUiState extends Equatable {
  const LoginScreenUiState({
    required this.username,
    required this.password,
    required this.isLoading,
    required this.isLoginSuccess,
    required this.isLoginFailed,
    required this.errorMessage,
  });

  final String username;
  final String password;

  final bool isLoading;
  final bool isLoginSuccess;
  final bool isLoginFailed;

  final String? errorMessage;

  LoginScreenUiState copyWith({
    String? username,
    String? password,
    bool? isLoading,
    bool? isLoginSuccess,
    bool? isLoginFailed,
    String? errorMessage,
  }) {
    return LoginScreenUiState(
      username: username ?? this.username,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isLoginSuccess: isLoginSuccess ?? this.isLoginSuccess,
      isLoginFailed: isLoginFailed ?? this.isLoginFailed,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        username,
        password,
        isLoading,
        isLoginSuccess,
        isLoginFailed,
      ];
}

class LoginScreenInitialState extends LoginScreenUiState {
  const LoginScreenInitialState()
      : super(
          username: '',
          password: '',
          isLoading: false,
          isLoginSuccess: false,
          isLoginFailed: false,
          errorMessage: null,
        );
}
