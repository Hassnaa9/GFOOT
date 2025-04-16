import 'package:flutter/material.dart';
import 'package:graduation_project/Features/home/presentation/views/learn_view_body.dart';

class Learn extends StatelessWidget {
  const Learn({super.key});
  static const String route = '/Learn';

  @override
  Widget build(BuildContext context) {
    return LearnViewBody();
  }
}