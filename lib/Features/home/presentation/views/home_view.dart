import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit_state.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/custom_carbon_result.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/custom_services.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/gradient_indicator.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/service_header.dart';
import 'package:graduation_project/Features/login&registration/login.dart';
import 'package:graduation_project/constants.dart';

class HomeViewBody extends StatefulWidget {
  final Map<String, dynamic> userAnswers;

  const HomeViewBody({super.key, required this.userAnswers});

  @override
  _HomeViewBodyState createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getCarbonFootprint();
    if (widget.userAnswers.isNotEmpty) {
      context.read<HomeCubit>().logActivity(queryParameters: widget.userAnswers);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "See your carbon footprint today!",
              style: TextStyle(fontSize: 17, color: MyColors.kPrimaryColor),
            ),
            SizedBox(height: screenHeight * .04),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator(color: MyColors.kPrimaryColor));
                } else if (state is HomeLoaded) {
                  final carbonFootprint = state.carbonValue;
                  final normalizedValue = (carbonFootprint / 5000).clamp(0.0, 1.0);

                  return Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth * .35,
                            height: screenWidth * .30,
                            child: GradientCircularProgressIndicator(
                              value: normalizedValue,
                              size: screenWidth * .8,
                              strokeWidth: 15.0,
                            ),
                          ),
                          CustomCarbonResult(carbonFootprint: carbonFootprint),
                        ],
                      ),
                      SizedBox(height: screenHeight * .027),
                      if (carbonFootprint > 0.00)
                        const Text(
                          "Good job!",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: MyColors.kPrimaryColor,
                          ),
                        ),
                      SizedBox(height: screenHeight * .01),
                    ],
                  );
                } else if (state is HomeNoData) {
                  return Column(
                    children: [
                      const Text(
                        'Please complete the questionnaire to see your carbon footprint.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * .01),
                    ],
                  );
                } else if (state is HomeError) {
                  print('HomeViewBody: Error state - ${state.errorMessage}');
                  if (state.errorMessage.contains('Please log in to continue')) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SignInScreen()),
                      );
                    });
                    return const Center(child: Text('Redirecting to login...'));
                  }
                  return Column(
                    children: [
                      Text('Error: ${state.errorMessage}'),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
            Align(
              alignment: Alignment.center,
              child: EnhancedServicesHeader(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ),
            SizedBox(height: screenHeight * .02),
            CustomServices(screenHeight: screenHeight, screenWidth: screenWidth),
          ],
        ),
      ),
    );
  }
}