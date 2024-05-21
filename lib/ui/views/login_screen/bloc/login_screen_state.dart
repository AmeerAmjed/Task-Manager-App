part of 'login_screen_bloc.dart';

abstract class LoginScreenState extends Equatable {
  const LoginScreenState();

  @override
  List<Object> get props => [];
}

class LoginScreenInitial extends LoginScreenState {}

class LoadingState extends LoginScreenState {}

class IsLoginSuccess extends LoginScreenState {}

class IsLoginFailure extends LoginScreenState {
  final String message;

  const IsLoginFailure(this.message);
}
