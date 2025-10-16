// lib/src/features/auth/application/login_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial());

  void toggleRememberMe(bool newValue) {
    // Desafío 2: Mantener el estado isRememberMeChecked en transiciones de estado
    if (state is LoginInitial) {
      emit(LoginInitial(isRememberMeChecked: newValue));
    } else if (state is LoginLoading) {
      emit(LoginLoading(isRememberMeChecked: newValue));
    } else if (state is LoginSuccess) {
      emit(LoginSuccess(
        isRememberMeChecked: newValue,
        message: (state as LoginSuccess).message,
      ));
    } else if (state is LoginFailure) {
      emit(LoginFailure(
        isRememberMeChecked: newValue,
        errorMessage: (state as LoginFailure).errorMessage,
      ));
    }
  }

  // Desafío 2: Método asíncrono para simular el flujo completo de login
  Future<void> performLogin(String email, String password) async {
    emit(LoginLoading(isRememberMeChecked: state.isRememberMeChecked));

    // Simula una llamada a API/backend con delay de 2 segundos
    await Future.delayed(const Duration(seconds: 2));

    // Desafío 2: Validación de credenciales específicas (múltiples usuarios)
    // Mapa de usuarios válidos: email -> password
    const validUsers = {
      'test@example.com': 'SecretPass',
      'cesarley817@gmail.com': '123456',
      'admin@example.com': 'admin123',
      'user@demo.com': 'demo2024',
    };

    // Verifica si el email existe y la contraseña coincide
    if (validUsers.containsKey(email) && validUsers[email] == password) {
      emit(LoginSuccess(
        isRememberMeChecked: state.isRememberMeChecked,
        message: 'Welcome, $email!',
      ));
    } else {
      emit(LoginFailure(
        isRememberMeChecked: state.isRememberMeChecked,
        errorMessage: 'Invalid credentials. Please check your email and password.',
      ));
    }
  }
}
