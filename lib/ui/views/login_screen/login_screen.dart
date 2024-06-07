import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/ui/utils/dimens.dart';
import 'package:task_manager/ui/utils/input_validation.dart';
import 'package:task_manager/ui/views/login_screen/bloc/login_screen_bloc.dart';
import 'package:task_manager/ui/views/login_screen/widget/custom_text_form_field.dart';
import 'package:task_manager/ui/widget/custom_button.dart';
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
                      // Navigator.popAndPushNamed(context, RoutesScreen.home);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Form Submitted Successfully!')),
                      );
                    } else if (state.isLoginFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage!)),
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
