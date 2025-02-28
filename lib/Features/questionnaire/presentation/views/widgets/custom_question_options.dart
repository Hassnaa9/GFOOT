import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';

class CustomQuestionOption extends StatefulWidget {
  final List<String> options;
  const CustomQuestionOption({super.key, required this.options});

  @override
  _CustomQuestionOptionState createState() => _CustomQuestionOptionState();
}

class _CustomQuestionOptionState extends State<CustomQuestionOption> {
  int? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Allows it to be inside a Column
      physics: const NeverScrollableScrollPhysics(), // Prevents nested scrolling
      itemCount: widget.options.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: MyColors.questions,
            borderRadius: BorderRadius.circular(16),
          ),
          child: RadioListTile<int>(
            value: index,
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() => _selectedOption = value);
            },
            title: Text(
              widget.options[index],
              style: const TextStyle(color: Colors.white),
            ),
            activeColor: Colors.white,
          ),
        );
      },
    );
  }
}
