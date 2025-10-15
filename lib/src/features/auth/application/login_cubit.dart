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

    // Desafío 2: Validación de credenciales específicas
    const validEmail = 'test@example.com';
    const validPassword = 'SecretPass';

    if (email == validEmail && password == validPassword) {
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
