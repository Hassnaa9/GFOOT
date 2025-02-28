import 'package:flutter/material.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/Features/questionnaire/presentation/views/widgets/custom_question_options.dart';
import 'package:graduation_project/Features/questionnaire/presentation/views/widgets/question_card.dart';
import 'package:graduation_project/constants.dart';

class QuestionnaireViewBody extends StatefulWidget {
  const QuestionnaireViewBody({super.key});

  @override
  State<QuestionnaireViewBody> createState() => _QuestionnaireViewBodyState();
}

class _QuestionnaireViewBodyState extends State<QuestionnaireViewBody> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  
  final List<String> questions = [
    "How would you describe your flying habits in a typical, average year?",
    " How often do you use public transportation (bus, train, metro)?",
    "What type of vehicle do you primarily use?",
    "How many kilometers/miles do you drive per week?",
    " How is your home primarily powered?",
    " How often do you eat meat?"
  ];

  final List<List<String>> options = [
    ['🛫 I fly rarely or never',
'✈️ Occasionally (1-3 times per year)',
'🛬 Regular (4+ times per year)',
'🛩 Enter custom amount'],
    [
      '🚋 Never',
'🚎 Sometimes (1-3 times a week)',
'🚆 Regularly (4+ times a week)',
'🚌 Always',
    ],
    [
      '🚲 I don’t use a vehicle (bike/walk)',
'🚗 Small or hybrid car',
'🚙 Large gasoline/diesel vehicle',
'🚛 Heavy-duty vehicle',
    ],
    [
      '🚶 0 km/miles (I don’t drive)',
'🚗 Less than 100 km/miles',
'🚙 100-500 km/miles',
'🚛 More than 500 km/miles',
    ],
    ['☀️ Renewable energy (solar/wind)',
'🔥 Natural gas',
'⚡ Electricity (grid-based)',
'🏠 Mixed sources'],
[
  '🥦 Never (Vegetarian/Vegan)',
'🍗 Occasionally (1-3 times a week)',
'🍖 Regularly (4-6 times a week)',
'🥩 Daily'
],
['👚 Rarely (Few times a year)',
'👗 Occasionally (Every few months)',
'👠 Regularly (Monthly)',
'🛍 Frequently (Weekly)']
  ];

  void _nextPage() {
    if (_currentPage < questions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              AssetsData.questionnaire, 
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              SizedBox(height: screenHeight * .03),
              // Logo
              Image.asset(AssetsData.logo, height: screenHeight * .3),
              const SizedBox(height: 20),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return QuestionCard(
                      question: questions[index],
                      options: options[index],
                    );
                  },
                ),
              ),
             Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0x44FBFBF7), // Semi-transparent white
                    foregroundColor: Colors.white,
                    minimumSize:
                        Size(screenWidth * 0.28, 41),
                    elevation: 2, // Removes shadow to allow transparency
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(26), // Rounded corners
                    ),
                  ),
                  child: Image.asset(
                    AssetsData.arrow,
                    height: 20, // Adjust size if needed
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
