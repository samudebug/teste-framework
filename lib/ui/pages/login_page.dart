import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_framework/blocs/auth_bloc/auth_bloc.dart';
import 'package:teste_framework/cubits/login_cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formState = GlobalKey();
  final LoginCubit _cubit = LoginCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formState,
        child: BlocBuilder<LoginCubit, Credentials>(
          bloc: _cubit,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 200,
                  child: Center(
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: "Username"),
                    onChanged: (value) {
                      _cubit.setUsername(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Senha",
                    ),
                    onChanged: (value) {
                      _cubit.setPassword(value);
                    },
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    child: const Text("ENTRAR"),
                    onPressed: () {
                      context.read<AuthBloc>().add(Login(state));
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
