import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/ui/route/routes_screen.dart';
import 'package:task_manager/ui/utils/dimens.dart';
import 'package:task_manager/ui/utils/input_validation.dart';
import 'package:task_manager/ui/views/login_screen/bloc/login_screen_bloc.dart';
import 'package:task_manager/ui/widget/loading.dart';
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
                const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
                const Text(
                  'Please sing in to continue.',
                  style: TextStyle(fontSize: 20),
                ),
                const VerticalSpace45(),
                TextFormField(
                  controller: bloc.usernameController,
                  validator: (username) =>
                      bloc.checkValidateUserName(username).message,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
                const VerticalSpace16(),
                TextFormField(
                  obscureText: true,
                  controller: bloc.passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  validator: (password) =>
                      bloc.checkValidatePassword(password).message,
                ),
                BlocConsumer<LoginScreenBloc, LoginScreenState>(
                  listener: (context, state) {
                    if (state is IsLoginSuccess) {
                      Navigator.popAndPushNamed(context, RoutesScreen.home);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Form Submitted Successfully!')),
                      );
                    } else if (state is IsLoginFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                        vertical: Dimens.spacing16,
                      ),
                      child: ElevatedButton(
                        onPressed: state is LoadingState
                            ? null
                            : () {
                                BlocProvider.of<LoginScreenBloc>(context)
                                    .add(Submitted());
                              },
                        child: BlocBuilder<LoginScreenBloc, LoginScreenState>(
                            builder: (BuildContext context, state) {
                          if (state is LoadingState) {
                            return const Loading();
                          }

                          return const Text('Submit');
                        }),
                      ),
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
