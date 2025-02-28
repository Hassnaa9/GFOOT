import 'package:flutter/material.dart';
import 'package:graduation_project/Features/login&registration/presentation/views/login_or_reg_view_body.dart';

class SigninOrSignupScreen extends StatefulWidget {
  const SigninOrSignupScreen({super.key});
  final String route = '/SigninOrSignup';

  @override
  State<SigninOrSignupScreen> createState() => _SigninOrSignupScreenState();
}

class _SigninOrSignupScreenState extends State<SigninOrSignupScreen> {


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginOrRegBody(),
    );
  }
}
