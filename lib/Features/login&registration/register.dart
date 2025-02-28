import 'package:flutter/material.dart';
import 'package:graduation_project/Features/login&registration/presentation/views/register_view_body.dart';

class SignUpScreen extends StatelessWidget {
  final String route ='/SignUp';

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body:  RegisterBody(),
    );
  }
}
