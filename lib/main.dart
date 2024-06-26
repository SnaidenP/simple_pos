import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_pos/src/config/database.dart';
import 'package:simple_pos/src/login/screen/login_screen.dart';

void main() {
  final database = Database();
  runApp(
    Provider(
      create: (context) => database,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Simple POS',
      home: LoginPage(),
    );
  }
}
