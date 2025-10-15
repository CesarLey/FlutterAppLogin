// lib/main.dart
import 'package:flutter/material.dart';
import 'src/features/auth/presentation/screens/login_screen.dart';
import 'src/core/presentation/app_theme.dart'; // Desafío 4: Tema centralizado

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Demo',
      debugShowCheckedModeBanner: false,
      // Desafío 4: Usar tema centralizado desde app_theme.dart
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.system, // Sigue el tema del sistema operativo
      home: const LoginScreen(),
    );
  }
}
