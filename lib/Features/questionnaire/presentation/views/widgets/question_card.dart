import 'package:flutter/material.dart';
import 'package:graduation_project/Features/questionnaire/presentation/views/widgets/custom_question_options.dart';
import 'package:graduation_project/constants.dart';

class QuestionCard extends StatefulWidget {
  final String question;
  final String type;
  final List<String>? options;
  final String keyName;
  final Function(String, dynamic) onChanged;

  const QuestionCard({
    super.key,
    required this.question,
    required this.type,
    this.options,
    required this.keyName,
    required this.onChanged,
  });

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: MyColors.questions,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    widget.question,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    softWrap: true,
                  ),
                ),
                SizedBox(height: screenHeight * .03),
                if (widget.type == 'multiple_choice' && widget.options != null)
                  CustomQuestionOption(
                    options: widget.options!,
                    keyName: widget.keyName, // Pass keyName
                    onSelected: (key, value) => widget.onChanged(key, value), // Update callback
                  )
                else
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter value',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      errorText: _errorText,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        final parsedValue = double.tryParse(value);
                        if (parsedValue == null) {
                          _errorText = 'Invalid number';
                        } else if (widget.keyName == 'how_long_tv_pc_daily_hour' ||
                            widget.keyName == 'how_long_internet_daily_hour') {
                          if (parsedValue < 0 || parsedValue > 24) {
                            _errorText = 'Must be between 0 and 24 hours';
                          } else {
                            _errorText = null;
                            // Convert to int for fields that expect integers
                            if (widget.keyName == 'how_long_tv_pc_daily_hour' ||
                                widget.keyName == 'how_long_internet_daily_hour' ||
                                widget.keyName == 'waste_bag_weekly_count' ||
                                widget.keyName == 'how_many_new_clothes_monthly') {
                              widget.onChanged(widget.keyName, parsedValue.toInt());
                            } else {
                              widget.onChanged(widget.keyName, parsedValue);
                            }
                          }
                        } else if (parsedValue < 0) {
                          _errorText = 'Must be a positive number';
                        } else {
                          _errorText = null;
                          // Convert to int for fields that expect integers
                          if (widget.keyName == 'waste_bag_weekly_count' ||
                              widget.keyName == 'how_many_new_clothes_monthly') {
                            widget.onChanged(widget.keyName, parsedValue.toInt());
                          } else {
                            widget.onChanged(widget.keyName, parsedValue);
                          }
                        }
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}