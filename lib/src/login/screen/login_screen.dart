import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pos/src/config/constants.dart';
import 'package:simple_pos/src/config/database.dart';
import 'package:simple_pos/src/login/cubit/login_cubit.dart';
import 'package:simple_pos/src/login/data/repository.dart';
import 'package:simple_pos/src/login/screen/registe_screen.dart';
import 'package:simple_pos/src/login/widgets/custom_login_buttom.dart';
import 'package:simple_pos/src/login/widgets/custom_login_textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginCubit(LoginRepositoryImpl(database: Database())),
      child: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final username = TextEditingController();
    final password = TextEditingController();

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (user) {
            // ignore: avoid_print
            print('User: $user');
          },
          error: (error) {
            if (error == 'Bad state: No element') {
              error = 'Usuario o contraseña incorrectos';
            }
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
                    ),
                  ),
                );
              },
            );
          },
          orElse: () {},
        );
      },
      child: ColoredBox(
        color: bgColor,
        child: Center(
          child: SizedBox(
            width: width / 2.5,
            height: height / 1.5,
            child: Card(
              color: bgColor2,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onLongPress: () => Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (context) => const RegisterPage(),
                      ),
                    ),
                    child: SizedBox(
                      width: width / 10,
                      child: Image.asset('assets/logo.png'),
                    ),
                  ),
                  const Text(
                    programName,
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  CustomLoginTextField(
                    labelText: 'Nombre de usuario',
                    isPassword: false,
                    controller: username,
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  CustomLoginTextField(
                    labelText: 'Contraseña',
                    isPassword: true,
                    controller: password,
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  CustomLoginButton(
                    labelText: 'Iniciar Sesion',
                    onPressed: () {
                      context
                          .read<LoginCubit>()
                          .login(username.text, password.text);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
