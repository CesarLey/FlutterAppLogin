// lib/src/features/auth/application/login_state.dart

// Desafío 2: LoginState como jerarquía sellada para representar el flujo completo
abstract class LoginState {
  final bool isRememberMeChecked;

  const LoginState({this.isRememberMeChecked = false});
}

class LoginInitial extends LoginState {
  const LoginInitial({super.isRememberMeChecked});
}

class LoginLoading extends LoginState {
  const LoginLoading({super.isRememberMeChecked});
}

class LoginSuccess extends LoginState {
  final String message;

  const LoginSuccess({
    super.isRememberMeChecked,
    this.message = 'Login successful!',
  });
}

class LoginFailure extends LoginState {
  final String errorMessage;

  const LoginFailure({
    super.isRememberMeChecked,
    required this.errorMessage,
  });
}
