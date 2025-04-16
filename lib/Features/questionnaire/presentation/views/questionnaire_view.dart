import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/Data/repository/activity_repository.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit.dart';
import 'package:graduation_project/Features/home/presentation/views/home_view.dart';
import 'package:graduation_project/Features/questionnaire/presentation/views/widgets/question_card.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/Core/api/end_points.dart';

class QuestionnaireViewBody extends StatefulWidget {
  const QuestionnaireViewBody({super.key});

  @override
  State<QuestionnaireViewBody> createState() => _QuestionnaireViewBodyState();
}

class _QuestionnaireViewBodyState extends State<QuestionnaireViewBody> with SingleTickerProviderStateMixin {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  final Map<String, dynamic> _responses = {};
  late AnimationController _buttonAnimationController;
  late Animation<double> _buttonScaleAnimation;

 final List<Map<String, dynamic>> questions = [
  {
    'text': '🏋️‍♀️ What is your body type?',
    'type': 'multiple_choice',
    'options': ['⚖️ overweight', '⚖️ obese', '⚖️ underweight', '⚖️ normal'],
    'key': 'body_type'
  },
  {
    'text': '👤 What is your gender?',
    'type': 'multiple_choice',
    'options': ['♂️ male', '♀️ female'],
    'key': 'sex'
  },
  {
    'text': '🍽️ What is your diet type?',
    'type': 'multiple_choice',
    'options': ['🐟 pescatarian', '🥗 vegetarian', '🍖 omnivore', '🌱 vegan'],
    'key': 'diet'
  },
  {
    'text': '🚿 How frequently do you shower?',
    'type': 'multiple_choice',
    'options': ['📅 daily', '⏳ less frequently', '⏰ more frequently', '🕒 twice a day'],
    'key': 'how_often_shower'
  },
  {
    'text': '🔥 What is your home’s primary heating energy source?',
    'type': 'multiple_choice',
    'options': ['🪨 coal', '💨 natural gas', '🪵 wood', '⚡ electricity'],
    'key': 'heating_energy_source'
  },
  {
    'text': '🚗 What is your primary mode of transportation?',
    'type': 'multiple_choice',
    'options': ['🚌 public', '🚶‍♂️ walk/bicycle', '🚘 private'],
    'key': 'transport'
  },
  {
    'text': '🚙 What type of vehicle you use?',
    'type': 'multiple_choice',
    'options': ['❓ NaN', '⛽ petrol', '🛢️ diesel', '🔋 hybrid', '💧 lpg', '⚡ electric'],
    'key': 'vehicle_type_detailed'
  },
  {
    'text': '🎉 How often do you participate in social activities?',
    'type': 'multiple_choice',
    'options': ['🥳 often', '🚫 never', '🤷‍♂️ sometimes'],
    'key': 'social_activity'
  },
  {
    'text': '🛒 What is your average monthly grocery bill (in your local currency)?',
    'type': 'numeric',
    'key': 'monthly_grocery_bill'
  },
  {
    'text': '✈️ How often did you travel by air?',
    'type': 'multiple_choice',
    'options': ['🚫 never', '🌟 rarely', '🛫 frequently', '✈️ very frequently'],
    'key': 'frequency_of_traveling_by_air'
  },
  {
    'text': '🛣️ How many kilometers do you drive per month?',
    'type': 'numeric',
    'key': 'vehicle_monthly_distance_km'
  },
  {
    'text': '🗑️ What is the size of your garbage bag?',
    'type': 'multiple_choice',
    'options': ['📏 small', '📏 medium', '📏 large'],
    'key': 'waste_bag_size'
  },
  {
    'text': '♻️ On average, how many garbage bags did your household use weekly?',
    'type': 'numeric',
    'key': 'waste_bag_weekly_count'
  },
  {
    'text': '📺 On average, how many hours do you spend daily watching TV or using a PC?',
    'type': 'numeric',
    'key': 'how_long_tv_pc_daily_hour'
  },
  {
    'text': '🌐 On average, how many hours do you spend online daily?',
    'type': 'numeric',
    'key': 'how_long_internet_daily_hour'
  },
  {
    'text': '👕 On average, how many new clothes do you buy per month?',
    'type': 'numeric',
    'key': 'how_many_new_clothes_monthly'
  },
  {
    'text': '💡 Do you actively seek out energy-efficient appliances?',
    'type': 'multiple_choice',
    'options': ['✅ Yes', '🤔 Sometimes', '❌ No'],
    'key': 'energy_efficiency'
  },
];
  @override
  void initState() {
    super.initState();
    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _buttonAnimationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < questions.length - 1) {
      _buttonAnimationController.forward().then((_) => _buttonAnimationController.reverse());
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _submitResponses();
    }
  }

  void _submitResponses() {
    print('Responses: $_responses');
    List<String> missingQuestions = [];
    List<String> invalidQuestions = [];

    for (var question in questions) {
      final key = question['key'];
      final value = _responses[key];
      if (value == null || (value is String && value.trim().isEmpty)) {
        missingQuestions.add(question['text']);
      } else if (question['type'] == 'numeric') {
        // Validate numeric fields
        final stringValue = value.toString();
        if (double.tryParse(stringValue) == null) {
          invalidQuestions.add('${question['text']} (must be a valid number)');
        }
      }
    }

    if (missingQuestions.isNotEmpty) {
      print('Missing or empty responses for: $missingQuestions');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please answer: ${missingQuestions.join(", ")}',
            style: const TextStyle(fontSize: 12),
          ),
          duration: const Duration(seconds: 5),
        ),
      );
      return;
    }

    if (invalidQuestions.isNotEmpty) {
      print('Invalid responses for: $invalidQuestions');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please correct: ${invalidQuestions.join(", ")}',
            style: const TextStyle(fontSize: 12),
          ),
          duration: const Duration(seconds: 5),
        ),
      );
      return;
    }

    // Format responses using ApiKey with API-friendly formatting
    final queryParameters = {
      ApiKey.bodyType: _responses['body_type'].toString().toLowerCase(),
      ApiKey.sex: _responses['sex'].toString().toLowerCase(),
      ApiKey.diet: _responses['diet'].toString().toLowerCase(),
      ApiKey.shower: _responses['how_often_shower'].toString().toLowerCase(),
      ApiKey.heatSrs: _responses['heating_energy_source'].toString().toLowerCase(),
      ApiKey.transport: _responses['transport'].toString().toLowerCase(),
      ApiKey.vehicleType: _responses['vehicle_type_detailed'].toString().toLowerCase(),
      ApiKey.socialActivity: _responses['social_activity'].toString().toLowerCase(),
      ApiKey.groceryBill: double.parse(_responses['monthly_grocery_bill'].toString()),
      ApiKey.travelFreq: _responses['frequency_of_traveling_by_air'].toString().toLowerCase(),
      ApiKey.vehicleDist: double.parse(_responses['vehicle_monthly_distance_km'].toString()),
      ApiKey.wastedBag: _responses['waste_bag_size'].toString().toLowerCase(),
      ApiKey.wastedBagCnt: int.parse(_responses['waste_bag_weekly_count'].toString()),
      ApiKey.dailyTv: int.parse(_responses['how_long_tv_pc_daily_hour'].toString()),
      ApiKey.dailyInternet: int.parse(_responses['how_long_internet_daily_hour'].toString()),
      ApiKey.monthlyCloth: int.parse(_responses['how_many_new_clothes_monthly'].toString()),
      ApiKey.energyEff: _responses['energy_efficiency'].toString(),
    };

    print('Submitting queryParameters: $queryParameters');

    // Navigate to HomeViewBody
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => HomeCubit(context.read<ActivityRepository>()),
          child: HomeViewBody(userAnswers: queryParameters),
        ),
      ),
    );
  }

  void _saveResponse(String key, dynamic value) {
    setState(() {
      _responses[key] = value;
      print('Saved: $key = $value');
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AssetsData.questionnaire,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              SizedBox(height: screenHeight * .03),
              Image.asset(AssetsData.logo, height: screenHeight * .3),
              SizedBox(height: screenHeight * .03),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: LinearGradient(
                    colors: [
                      MyColors.questions,
                      MyColors.questions.withOpacity(0.5),
                    ],
                    stops: [(_currentPage + 1) / questions.length, (_currentPage + 1) / questions.length],
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: (_currentPage + 1) / questions.length,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: MyColors.questions,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * .03),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return QuestionCard(
                      question: questions[index]['text'],
                      type: questions[index]['type'],
                      options: questions[index]['options'],
                      keyName: questions[index]['key'],
                      onChanged: _saveResponse,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       if (_currentPage > 0)
                      ScaleTransition(
                        scale: _buttonScaleAnimation,
                        child: ElevatedButton(
                           onPressed: () {
                            _buttonAnimationController.forward().then((_) => _buttonAnimationController.reverse());
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0x44FBFBF7),
                            minimumSize: Size(screenWidth * 0.28, 41),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                          child:  Image.asset(
                                  AssetsData.left_arrow,
                                  height: 20,
                                ),
                        ),
                      ),
                      ScaleTransition(
                        scale: _buttonScaleAnimation,
                        child: ElevatedButton(
                          onPressed: _nextPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0x44FBFBF7),
                            minimumSize: Size(screenWidth * 0.28, 41),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                          child: _currentPage == questions.length - 1
                              ? const Text(
                                  'Submit',
                                  style: TextStyle(color: MyColors.questions, fontSize: 20),
                                )
                              : Image.asset(
                                  AssetsData.arrow,
                                  height: 20,
                                ),
                        ),
                      ),
                    ],
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