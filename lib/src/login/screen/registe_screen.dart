// register screen
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pos/src/config/constants.dart';
import 'package:simple_pos/src/config/database.dart';
import 'package:simple_pos/src/login/cubit/login_cubit.dart';
import 'package:simple_pos/src/login/data/repository.dart';
import 'package:simple_pos/src/login/screen/login_screen.dart';
import 'package:simple_pos/src/login/widgets/custom_login_buttom.dart';
import 'package:simple_pos/src/login/widgets/custom_login_textfield.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginCubit(LoginRepositoryImpl(database: Database())),
      child: const RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final username = TextEditingController();
    final password = TextEditingController();
    final name = TextEditingController();

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        // register user
        state.maybeWhen(
          success: (user) {
            showDialog<String>(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 50,
                  ),
                  content: Text(
                    'Usuario registrado',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                );
              },
            );
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.push(
                context,
                MaterialPageRoute<Widget>(
                  builder: (context) {
                    return const LoginPage();
                  },
                ),
              );
            });
          },
          error: (error) {
            showDialog<String>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 50,
                  ),
                  content: Text(
                    'Intente Nuevamente\n$error',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: bgColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Registro',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomLoginTextField(
                labelText: 'Nombre',
                controller: name,
                isPassword: false,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomLoginTextField(
                labelText: 'Correo',
                controller: username,
                isPassword: false,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomLoginTextField(
                labelText: 'Contraseña',
                controller: password,
                isPassword: true,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomLoginButton(
                labelText: 'Registrar',
                onPressed: () {
                  context.read<LoginCubit>().register(
                        username.text,
                        password.text,
                        name.text,
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
