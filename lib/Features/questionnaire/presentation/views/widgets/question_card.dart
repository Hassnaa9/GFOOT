import 'package:flutter/material.dart';
import 'package:graduation_project/Features/questionnaire/presentation/views/widgets/custom_question_options.dart';
import 'package:graduation_project/constants.dart';


class QuestionCard extends StatelessWidget {
  final String question;
  final List<String> options;

  const QuestionCard({super.key, required this.question, required this.options});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: MyColors.questions,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              question,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              softWrap: true,
            ),
          ),
          SizedBox(height: screenHeight * .03),
          CustomQuestionOption(options: options),
        ],
      ),
    );
  }
}
