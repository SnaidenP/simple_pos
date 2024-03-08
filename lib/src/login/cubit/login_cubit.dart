import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_pos/src/login/data/repository.dart';
import 'package:simple_pos/src/login/models/user.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.repository) : super(const LoginState.initial());
  final LoginRepository repository;

  Future<void> login(String email, String password) async {
    emit(const LoginState.loading());
    try {
      final user = await repository.login(email, password);
      emit(LoginState.success(user));
    } catch (e) {
      emit(LoginState.error(e.toString()));
    }
  }

  Future<void> register(String username, String password, String name) async {
    emit(const LoginState.loading());
    try {
      final user = await repository.register(username, password, name);
      emit(LoginState.success(user));
    } catch (e) {
      emit(LoginState.error(e.toString()));
    }
  }
}
