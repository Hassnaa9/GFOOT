import 'package:flutter/material.dart';
import 'package:graduation_project/Features/forget_password/presentation/views/change_password_view.dart';

class ChangePasswordScreen extends StatelessWidget {
  final String route = '/ChangePass';

  const ChangePasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: ChangePasswordBody(),
    );
  }
}


