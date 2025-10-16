// lib/src/features/auth/presentation/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/login_cubit.dart';
import '../../application/login_state.dart';
import '../../../../core/presentation/widgets/core_widgets.dart'; // Desafío 4

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Interactive Login'),
        ),
        body: const Center(
          child: SingleChildScrollView(
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  // Estado local/efímero para la visibilidad de la contraseña
  bool _isPasswordObscured = true;

  // Desafío 1: FocusNode para gestionar el foco entre campos
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  // Desafío 3: Controladores para obtener valores de email y password
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Desafío 1: Función separada para enviar el formulario
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Llama al método performLogin del Cubit
      context.read<LoginCubit>().performLogin(
            _emailController.text,
            _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Desafío 3: BlocListener para mostrar SnackBar en Success/Error
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          // Desafío 2: Limpiar formulario después de éxito
          _emailController.clear();
          _passwordController.clear();
          
          // Desafío 2: Mostrar SnackBar de éxito con colores visibles
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.green[700],
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
            ),
          );
          
          // Desafío 2: Navegación a HomeScreen (placeholder por ahora - TODO)
          // Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
          
        } else if (state is LoginFailure) {
          // Desafío 2: Mostrar AlertDialog para errores con colores visibles
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: Text(
                'Authentication Failed',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                state.errorMessage,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Text('Accept'),
                ),
              ],
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Desafío 4: Logo responsive sin dimensiones fijas
          LayoutBuilder(
            builder: (context, constraints) {
              // Calcula un tamaño máximo basado en el ancho disponible
              final logoSize = (MediaQuery.of(context).size.width * 0.4).clamp(100.0, 200.0);
              return SizedBox(
                height: logoSize,
                width: logoSize,
                child: Image.asset(
                  'assets/images/login_logo.png',
                  // Si el asset falta, mostramos un fallback amigable
                  errorBuilder: (context, error, stackTrace) => Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image_not_supported,
                      size: logoSize * 0.6,
                      color: Colors.redAccent,
                    ),
                  ),
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                // Desafío 4: Usar CustomFormField para email
                CustomFormField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  labelText: 'Email Address',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                  validator: (value) {
                    // Desafío 1: Validación avanzada con RegExp
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailRegExp = RegExp(r'^[a-zA-Z0-9_%+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$');
                    if (!emailRegExp.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Desafío 4: Usar CustomFormField para password con suffixIcon personalizado
                CustomFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  labelText: 'Password',
                  prefixIcon: Icons.lock,
                  textInputAction: TextInputAction.done,
                  obscureText: _isPasswordObscured,
                  // Desafío 1: onFieldSubmitted para enviar formulario al presionar "done"
                  onFieldSubmitted: (_) => _submitForm(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordObscured = !_isPasswordObscured;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return CheckboxListTile(
                      title: const Text('Remember Me'),
                      value: state.isRememberMeChecked,
                      onChanged: (newValue) {
                        // Se llama al Cubit para manejar lógica de negocio
                        context.read<LoginCubit>().toggleRememberMe(newValue ?? false);
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    );
                  },
                ),
                const SizedBox(height: 24),
                // Desafío 3: BlocBuilder para el botón que muestra loading y se deshabilita
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    final isLoading = state is LoginLoading;
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onPressed: isLoading
                          ? null // Deshabilita el botón durante la carga
                          : _submitForm, // Desafío 1: Usar función separada
                      child: isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                // Desafío 3: Usar color del tema en lugar de hardcodear
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            )
                          : const Text('LOGIN'),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      ), // Cierre del child de BlocListener
    ); // Cierre del BlocListener
  }
}
