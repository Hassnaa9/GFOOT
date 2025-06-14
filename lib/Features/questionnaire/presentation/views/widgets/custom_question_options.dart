import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
// Import the generated AppLocalizations class


class CustomQuestionOption extends StatefulWidget {
  final List<Map<String , dynamic>> options;
  final Function(String, String) onSelected; // Update to take keyName and value
  final String keyName; // Add keyName to pass to onSelected

  const CustomQuestionOption({
    super.key,
    required this.options,
    required this.onSelected,
    required this.keyName, // Add keyName parameter
  });

  @override
  _CustomQuestionOptionState createState() => _CustomQuestionOptionState();
}

class _CustomQuestionOptionState extends State<CustomQuestionOption> {
  int? _selectedOption;

  @override
  Widget build(BuildContext context) {
    // Note: The 'display' field in widget.options is expected to already be localized
    // from the questionnaire_view.dart where the questions list is built.
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
              setState(() {
              _selectedOption = value;
              widget.onSelected(
                widget.keyName,
                widget.options[index]['value'] as String, // Extract the 'value' field
              );
              });
            },
            title: Text(
              widget.options[index]['display'] as String, // This 'display' should now be localized
              style: const TextStyle(color: Colors.white),
            ),
            activeColor: Colors.white,
          ),
        );
      },
    );
  }
}
