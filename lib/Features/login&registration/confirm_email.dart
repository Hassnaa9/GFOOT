import 'package:flutter/material.dart';
import 'package:graduation_project/Features/login&registration/presentation/views/confirm_email_view.dart';

class ConfirmEmail extends StatelessWidget {
  const ConfirmEmail({super.key});
  final String route = '/ConfirmEmail';

  @override
  Widget build(BuildContext context) {
    return ConfirmEmailViewBody();
  }
}