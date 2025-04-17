import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/Features/home/learn.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit_state.dart';
import 'package:graduation_project/Features/home/presentation/views/learn_view_body.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/custom_carbon_result.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/custom_services.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/gradient_indicator.dart';
import 'package:graduation_project/Features/home/recommendations.dart';
import 'package:graduation_project/Features/login&registration/login.dart';
import 'package:graduation_project/Features/profile&setting/notifications.dart';
import 'package:graduation_project/Features/profile&setting/profile.dart';
import 'package:graduation_project/Features/profile&setting/setting.dart';
import 'package:graduation_project/constants.dart';

class HomeViewBody extends StatefulWidget {
  final Map<String, dynamic> userAnswers;

  const HomeViewBody({super.key, required this.userAnswers});

  @override
  _HomeViewBodyState createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Only call logActivity if userAnswers is not empty
    if (widget.userAnswers.isNotEmpty) {
      context.read<HomeCubit>().logActivity(queryParameters: widget.userAnswers);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
         Navigator.push(context, 
         MaterialPageRoute(builder: (context)=>const Learn()));
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Setting()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: const Color(0xffD4E0EB),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Notifications()),
                  );
                },
                child: Image.asset(
                  AssetsData.notify,
                  width: screenWidth * 0.2,
                  height: screenHeight * 0.2,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 6),
              const Text(
                "See your carbon footprint today!",
                style: TextStyle(fontSize: 18, color: MyColors.kPrimaryColor),
              ),
              SizedBox(height: screenHeight * .02),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(child: CircularProgressIndicator(color: MyColors.kPrimaryColor,));
                  } else if (state is HomeLoaded) {
                    final normalizedValue = (state.carbonValue / 5000).clamp(0.0, 1.0);
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: screenWidth * .30,
                          height: screenWidth * .30,
                          child: GradientCircularProgressIndicator(
                            value: normalizedValue,
                            size: screenWidth * .6,
                            strokeWidth: 13.0,
                          ),
                        ),
                        CustomCarbonResult(carbonFootprint: state.carbonValue),
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
                        Text('Error! ${state.errorMessage}'),
                        ElevatedButton(
                          onPressed: () {
                            if (widget.userAnswers.isNotEmpty) {
                              context.read<HomeCubit>().logActivity(queryParameters: widget.userAnswers);
                            }
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    );
                  }
                  return const Text(
                    'Please complete the questionnaire to see your carbon footprint.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  );
                },
              ),
              SizedBox(height: screenHeight * .02),
              const Text(
                "Good job!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: MyColors.kPrimaryColor),
              ),
              SizedBox(height: screenHeight * .01),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "My Services",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: MyColors.kPrimaryColor,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * .02),
              CustomServices(screenHeight: screenHeight, screenWidth: screenWidth),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: MyColors.kPrimaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetsData.home)),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetsData.recomend)),
            label: "Learn",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetsData.setting)),
            label: "Settings",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetsData.profile)),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}