import 'package:flutter/material.dart';
import 'package:simple_pos/src/config/database.dart';
import 'package:simple_pos/src/login/models/user.dart';

abstract class LoginRepository {
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String name);
}

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({required this.database});

  final Database database;

  @override
  Future<User> login(String email, String password) async {
    try {
      final user = await database.getUser(email, password);
      debugPrint('User: $user');
      return User.fromJson(user.first.fields);
    } catch (e) {
      return Future.error(e);
    }
  }

  // register username, password and name
  @override
  Future<User> register(String email, String password, String name) async {
    try {
      final register = await database.registerUser(email, password, name);
      if (register.affectedRows == 0) {
        return Future.error('Error al registrar usuario');
      } else {
        return User(username: email, name: name, password: password);
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
