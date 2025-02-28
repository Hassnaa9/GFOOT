import 'package:flutter/material.dart';
import 'package:graduation_project/Features/questionnaire/presentation/views/questionnaire_view.dart';
class Questionnaire extends StatelessWidget {
  const Questionnaire({super.key});
    final String route = '/Calculations';

  @override
  Widget build(BuildContext context) {
    return QuestionnaireViewBody();
  }
}