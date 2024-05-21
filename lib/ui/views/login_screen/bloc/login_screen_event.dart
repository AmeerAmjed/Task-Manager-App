part of 'login_screen_bloc.dart';

@immutable
abstract class LoginScreenEvent extends Equatable {
  const LoginScreenEvent();

  @override
  List<Object> get props => [];
}

@immutable
class Submitted extends LoginScreenEvent {}