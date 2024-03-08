import 'package:flutter/material.dart';
import 'package:simple_pos/src/login/screen/login_screen.dart';
import 'package:simple_pos/src/pos/screen/pos_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Simple POS',
      home: PosScreen(),
    );
  }
}
