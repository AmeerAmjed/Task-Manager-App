import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/di/get_it.dart';
import 'package:task_manager/domain/usecase/user_usecase.dart';
import 'package:task_manager/ui/utils/input_validation.dart';
import 'package:task_manager/utils/handle_error.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenUiState>
    with InputValidation {
  final GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserUsecase authentication =
      getIt.get<UserUsecase>();

  LoginScreenBloc() : super(const LoginScreenInitialState()) {
    on<LoginScreenEvent>((event, emit) async {});

    on<Submitted>((event, emit) async {
      await _onSubmitted(event, emit);
    });
  }

  Future _onSubmitted(Submitted event, Emitter<LoginScreenUiState> emit) async {
    if (_checkFormValidation()) {
      emit(state.copyWith(isLoading: true));
      try {
        final response = await authentication.login(
          username: usernameController.text.trim(),
          password: passwordController.text.trim(),
        );
        if (response) {
          emit(state.copyWith(
            isLoading: false,
            isLoginSuccess: true,
          ));
        } else {
          emit(state.copyWith(
            isLoading: false,
            isLoginFailed: true,
            errorMessage: "error",
          ));
        }
      } on Exception catch (e) {
        if (e is BadRequestException) {
          emit(state.copyWith(
            isLoading: false,
            isLoginFailed: true,
            errorMessage: e.message,
          ));
        } else if (e is ServerException) {
          emit(state.copyWith(
            isLoading: false,
            isLoginFailed: true,
            errorMessage: e.message,
          ));
        } else {
          emit(state.copyWith(
            isLoading: false,
            isLoginFailed: true,
            errorMessage: "An unknown error occurred",
          ));
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
