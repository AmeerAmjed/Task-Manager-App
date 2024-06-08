import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/ui/utils/dimens.dart';
import 'package:task_manager/ui/utils/input_validation.dart';
import 'package:task_manager/ui/views/home_screen/home_route.dart';
import 'package:task_manager/ui/views/login_screen/bloc/login_screen_bloc.dart';
import 'package:task_manager/ui/views/login_screen/widget/custom_text_form_field.dart';
import 'package:task_manager/ui/widget/custom_button.dart';
import 'package:task_manager/ui/widget/toast.dart';
import 'package:task_manager/ui/widget/vertical_space.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginScreenBloc>();
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: bloc.formLoginKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: Dimens.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const VerticalSpace96(),
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  'Please sing in to continue.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const VerticalSpace45(),
                CustomTextFormField(
                  label: 'User Name',
                  controller: bloc.usernameController,
                  validator: (username) =>
                      bloc.checkValidateUserName(username).message,
                ),
                const VerticalSpace16(),
                CustomTextFormField(
                  label: 'Password',
                  controller: bloc.passwordController,
                  validator: (password) =>
                      bloc.checkValidatePassword(password).message,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {
                    bloc.add(Submitted());
                  },
                ),
                BlocConsumer<LoginScreenBloc, LoginScreenUiState>(
                  listener: (context, state) {
                    if (state.isLoginSuccess) {
                      toast(
                        "Login Success",
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        textColor: Theme.of(context).colorScheme.onPrimary,
                      );
                      context.go(homeRoute.path);
                    } else if (state.isLoginFailed) {
                      toast(
                        state.errorMessage!,
                        backgroundColor:
                            Theme.of(context).colorScheme.errorContainer,
                        textColor: Theme.of(context).colorScheme.onPrimary,
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      label: 'Submit',
                      isLoading: state.isLoading,
                      onPressed: () {
                        bloc.add(Submitted());
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
