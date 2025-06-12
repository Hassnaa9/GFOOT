import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/Data/repository/activity_repository.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit.dart';
import 'package:graduation_project/Features/home/presentation/views/home_view.dart';
import 'package:graduation_project/Features/questionnaire/presentation/views/widgets/question_card.dart';
import 'package:graduation_project/app_localizations.dart';
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

  // The list of questions will now be built dynamically in the build method
  // using localized strings.

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
    // Get the localization instance for this method (if needed)
    final l10n = AppLocalizations.of(context)!;
    
    // Define questions inside a method or make it dependent on context for localization
    final List<Map<String, dynamic>> questions = _buildQuestions(l10n);

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
    final l10n = AppLocalizations.of(context)!; // Get localization instance
    print('Responses: $_responses');

    // Re-build questions list to get localized texts for validation messages
    final List<Map<String, dynamic>> questions = _buildQuestions(l10n);

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
          invalidQuestions.add('${question['text']} (${l10n.questionnaireMustBeNumber})'); // Localized
        }
      }
    }

    if (missingQuestions.isNotEmpty) {
      print('Missing or empty responses for: $missingQuestions');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${l10n.questionnairePleaseAnswer}: ${missingQuestions.join(", ")}', // Localized
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
            '${l10n.questionnairePleaseCorrect}: ${invalidQuestions.join(", ")}', // Localized
            style: const TextStyle(fontSize: 12),
          ),
          duration: const Duration(seconds: 5),
        ),
      );
      return;
    }

    // Format responses using ApiKey with API-friendly formatting
    final queryParameters = {
      ApiKey.bodyType:_responses['body_type'].toString().toLowerCase(),
      ApiKey.sex:_responses['sex'].toString().toLowerCase(),
      ApiKey.diet:_responses['diet'].toString().toLowerCase(),
      ApiKey.shower:_responses['how_often_shower'].toString().toLowerCase(),
      ApiKey.heatSrs:_responses['heating_energy_source'].toString().toLowerCase(),
      ApiKey.transport:_responses['transport'].toString().toLowerCase(),
      ApiKey.vehicleType:_responses['vehicle_type_detailed'].toString().toLowerCase(),
      ApiKey.socialActivity:_responses['social_activity'].toString().toLowerCase(),
      ApiKey.groceryBill:double.parse(_responses['monthly_grocery_bill'].toString()),
      ApiKey.travelFreq:_responses['frequency_of_traveling_by_air'].toString().toLowerCase(),
      ApiKey.vehicleDist:double.parse(_responses['vehicle_monthly_distance_km'].toString()),
      ApiKey.wastedBag:_responses['waste_bag_size'].toString().toLowerCase(),
      ApiKey.wastedBagCnt:int.parse(_responses['waste_bag_weekly_count'].toString()),
      ApiKey.dailyTv:int.parse(_responses['how_long_tv_pc_daily_hour'].toString()),
      ApiKey.dailyInternet:int.parse(_responses['how_long_internet_daily_hour'].toString()),
      ApiKey.monthlyCloth:int.parse(_responses['how_many_new_clothes_monthly'].toString()),
      ApiKey.energyEff:_responses['energy_efficiency'].toString(),
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

  // Method to build questions list with localized strings
  List<Map<String, dynamic>> _buildQuestions(AppLocalizations l10n) {
    return [
      {
        'text': l10n.questionnaireBodyType,
        'type': 'multiple_choice',
        'options': [
          {'display': l10n.bodyTypeObese, 'value': 'obese'},
          {'display': l10n.bodyTypeOverweight, 'value': 'overweight'},
          {'display': l10n.bodyTypeUnderweight, 'value': 'underweight'},
          {'display': l10n.bodyTypeNormal, 'value': 'normal'},
        ],
        'key': 'body_type'
      },
      {
        'text': l10n.questionnaireGender,
        'type': 'multiple_choice',
        'options': [
          {'display': l10n.genderFemale, 'value': 'female'},
          {'display': l10n.genderMale, 'value': 'male'},
        ],
        'key': 'sex'
      },
      {
        'text': l10n.questionnaireDietType,
        'type': 'multiple_choice',
        'options': [
          {'display': l10n.dietOmnivore, 'value': 'omnivore'},
          {'display': l10n.dietVegetarian, 'value': 'vegetarian'},
          {'display': l10n.dietVegan, 'value': 'vegan'},
          {'display': l10n.dietPescatarian, 'value': 'pescatarian'},
        ],
        'key': 'diet'
      },
      {
        'text': l10n.questionnaireShowerFrequency,
        'type': 'multiple_choice',
        'options': [
          {'display': l10n.showerTwiceDaily, 'value': 'twice a day'},
          {'display': l10n.showerDaily, 'value': 'daily'},
          {'display': l10n.showerLessFrequently, 'value': 'less frequently'},
          {'display': l10n.showerMoreFrequently, 'value': 'more frequently'},
        ],
        'key': 'how_often_shower'
      },
      {
        'text': l10n.questionnaireHeatingSource,
        'type': 'multiple_choice',
        'options': [
          {'display': l10n.heatingCoal, 'value': 'coal'},
          {'display': l10n.heatingNaturalGas, 'value': 'natural gas'},
          {'display': l10n.heatingWood, 'value': 'wood'},
          {'display': l10n.heatingElectricity, 'value': 'electricity'},
        ],
        'key': 'heating_energy_source'
      },
      {
        'text': l10n.questionnaireTransportation,
        'type': 'multiple_choice',
        'options': [
          {'display': l10n.transportPrivate, 'value': 'private'},
          {'display': l10n.transportPublic, 'value': 'public'},
          {'display': l10n.transportWalkBicycle, 'value': 'walk/bicycle'},
        ],
        'key': 'transport'
      },
      {
        'text': l10n.questionnaireVehicleType,
        'type': 'multiple_choice',
        'options': [
          {'display': l10n.vehicleHybrid, 'value': 'hybrid'},
          {'display': l10n.vehiclePetrol, 'value': 'petrol'},
          {'display': l10n.vehicleDiesel, 'value': 'diesel'},
          {'display': l10n.vehicleLPG, 'value': 'lpg'},
          {'display': l10n.vehicleElectric, 'value': 'electric'},
          {'display': l10n.vehicleNaN, 'value': 'NaN'},
        ],
        'key': 'vehicle_type_detailed'
      },
      {
        'text': l10n.questionnaireSocialActivity,
        'type': 'multiple_choice',
        'options': [
          {'display': l10n.socialSometimes, 'value': 'sometimes'},
          {'display': l10n.socialOften, 'value': 'often'},
          {'display': l10n.socialNever, 'value': 'never'},
        ],
        'key': 'social_activity'
      },
      {
        'text': l10n.questionnaireMonthlyGrocery,
        'type': 'numeric',
        'key': 'monthly_grocery_bill'
      },
      {
        'text': l10n.questionnaireAirTravel,
        'type': 'multiple_choice',
        'options': [
          {'display': l10n.airTravelNever, 'value': 'never'},
          {'display': l10n.airTravelRarely, 'value': 'rarely'},
          {'display': l10n.airTravelFrequently, 'value': 'frequently'},
          {'display': l10n.airTravelVeryFrequently, 'value': 'very frequently'},
        ],
        'key': 'frequency_of_traveling_by_air'
      },
      {
        'text': l10n.questionnaireVehicleDistance,
        'type': 'numeric',
        'key': 'vehicle_monthly_distance_km'
      },
      {
        'text': l10n.questionnaireWasteBagSize,
        'type': 'multiple_choice',
        'options': [
          {'display': l10n.wasteBagMedium, 'value': 'medium'},
          {'display': l10n.wasteBagSmall, 'value': 'small'},
          {'display': l10n.wasteBagLarge, 'value': 'large'},
        ],
        'key': 'waste_bag_size'
      },
      {
        'text': l10n.questionnaireWasteBagCount,
        'type': 'numeric',
        'key': 'waste_bag_weekly_count'
      },
      {
        'text': l10n.questionnaireTvPcHours,
        'type': 'numeric',
        'key': 'how_long_tv_pc_daily_hour'
      },
      {
        'text': l10n.questionnaireInternetHours,
        'type': 'numeric',
        'key': 'how_long_internet_daily_hour'
      },
      {
        'text': l10n.questionnaireNewClothes,
        'type': 'numeric',
        'key': 'how_many_new_clothes_monthly'
      },
      {
        'text': l10n.questionnaireEnergyEfficiency,
        'type': 'multiple_choice',
        'options': [
          {'display': l10n.energyEfficiencyYes, 'value': 'Yes'},
          {'display': l10n.energyEfficiencySometimes, 'value': 'Sometimes'},
          {'display': l10n.energyEfficiencyNo, 'value': 'No'},
        ],
        'key': 'energy_efficiency'
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    // Get the localization instance
    final l10n = AppLocalizations.of(context)!;
    // Build questions list with localized strings
    final List<Map<String, dynamic>> questions = _buildQuestions(l10n);


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
                              ? Text( // No longer const
                                  l10n.submitButton, // Localized
                                  style: const TextStyle(color: MyColors.questions, fontSize: 20),
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
