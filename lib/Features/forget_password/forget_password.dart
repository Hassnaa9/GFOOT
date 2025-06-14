import 'package:flutter/material.dart';
import 'package:graduation_project/Features/forget_password/presentation/views/forget_password_view.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final String route = '/ForgetPass';

  ForgotPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme
    return  Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // Theme-aware background
      body: ForgetPasswordBody()
    );
  }
}

