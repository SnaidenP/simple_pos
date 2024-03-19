import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:simple_pos/src/checkout/cubit/client_cubit.dart';
import 'package:simple_pos/src/checkout/data/repository.dart';
import 'package:simple_pos/src/checkout/views/checkout_screen.dart';
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
