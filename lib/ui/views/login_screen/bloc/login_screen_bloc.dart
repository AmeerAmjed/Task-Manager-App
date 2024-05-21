import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/domain/usecase/authentication_usecase.dart';
import 'package:task_manager/ui/utils/input_validation.dart';
import 'package:task_manager/utils/handle_error.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState>
    with InputValidation {
  final GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthenticationUsecase authentication =
      getIt.get<AuthenticationUsecase>();

  LoginScreenBloc() : super(LoginScreenInitial()) {
    on<LoginScreenEvent>((event, emit) async {
      if (event is Submitted) {
        await _onSubmitted(event, emit);
      }
    });
  }

  Future _onSubmitted(Submitted event, Emitter<LoginScreenState> emit) async {
    if (_checkFormValidation()) {
      emit(LoadingState());
      try {
        final response = await authentication.login(
          username: usernameController.text.trim(),
          password: passwordController.text.trim(),
        );
        if (response) {
          emit(IsLoginSuccess());
        } else {
          emit(const IsLoginFailure("error"));
        }
      } on Exception catch (e) {
        if (e is BadRequestException) {
          emit(IsLoginFailure(e.message ?? ""));
        } else if (e is ServerException) {
          emit(IsLoginFailure(e.message ?? ""));
        } else {
          emit(const IsLoginFailure("An unknown error occurred"));
        }
      }
    }
  }

  bool _checkFormValidation() => formLoginKey.currentState!.validate();

  @override
  Future<void> close() {
    usernameController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
