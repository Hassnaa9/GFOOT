import 'package:flutter/material.dart';
import 'package:graduation_project/Features/profile/presentation/views/account_view.dart';

class Account extends StatelessWidget {
  const Account({super.key});
  final String route = '/Account';

  @override
  Widget build(BuildContext context) {
    return EditAccountViewBody();
  }
}