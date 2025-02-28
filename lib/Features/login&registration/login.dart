import 'package:flutter/material.dart';
import 'package:graduation_project/Features/login&registration/presentation/views/login_view_body.dart';

class SignInScreen extends StatelessWidget {
  final String route = '/SignIn';

  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: LoginBody(),
    );
  }
}
