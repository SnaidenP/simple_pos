import 'package:flutter/material.dart';
import 'package:simple_pos/src/config/constants.dart';

class CustomLoginTextField extends StatefulWidget {
  const CustomLoginTextField({
    required this.labelText,
    required this.isPassword,
    required this.controller,
    super.key,
  });
  final String labelText;
  final bool isPassword;
  final TextEditingController controller;

  @override
  State<CustomLoginTextField> createState() => _CustomLoginTextFieldState();
}

class _CustomLoginTextFieldState extends State<CustomLoginTextField> {
  bool showPassord = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3.5,
      child: TextFormField(
        controller: widget.controller,
        style: const TextStyle(color: primaryColor),
        // ignore: avoid_bool_literals_in_conditional_expressions
        obscureText: widget.isPassword ? !showPassord : false,
        decoration: InputDecoration(
          labelText: widget.labelText,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassord = !showPassord;
                    });
                  },
                  icon: Icon(
                    showPassord ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white.withOpacity(0.3),
                  ),
                )
              : null,
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
        ),
      ),
    );
  }
}
