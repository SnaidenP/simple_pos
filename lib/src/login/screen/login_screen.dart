import 'package:flutter/material.dart';
import 'package:simple_pos/src/config/constants.dart';
import 'package:simple_pos/src/login/widgets/custom_login_buttom.dart';
import 'package:simple_pos/src/login/widgets/custom_login_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ColoredBox(
      color: bgColor,
      child: Center(
        child: SizedBox(
          width: width / 2.5,
          height: height / 1.5,
          child: Card(
            color: bgColor2,
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: width / 10,
                  child: Image.asset('assets/logo.png'),
                ),
                const Text(
                  programName,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(
                  height: height / 40,
                ),
                LoginTextField(
                  labelText: 'Nombre de usuario',
                  isPassword: false,
                  onChanged: (p0) {},
                ),
                SizedBox(
                  height: height / 40,
                ),
                LoginTextField(
                  labelText: 'Contraseña',
                  isPassword: true,
                  onChanged: (p0) {},
                ),
                SizedBox(
                  height: height / 40,
                ),
                LoginButton(labelText: 'Iniciar Sesion', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
