import 'package:flutter/material.dart';
import 'package:graduation_project/Features/splash_screen/presentation/views/widgets/splash_custom_button.dart';
import '../../../../Core/utils/assets.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // Method to navigate to the next screen
    void navigateToLoginOrReg() {
      Navigator.pushReplacementNamed(context, '/SigninOrSignup');
    }

    return GestureDetector(
      onTap: navigateToLoginOrReg, // Navigate on tap
      child: Stack(
        fit: StackFit.expand, // To cover the entire screen
        children: [
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                child: Image.asset(AssetsData.splashImg),
              ),
            ),
          ),
          // Responsive Logo in the center
          Center(
            child: FractionallySizedBox(
              alignment: Alignment.center,
              child: Image.asset(
                AssetsData.logo, // Your logo file path
                fit: BoxFit.contain, // Keep the logo's aspect ratio
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.02,
            left: screenWidth * 0.45,
            child: Center(
              child:CustomSwipeButton(screenHeight: screenHeight,screenWidth: screenHeight,)

            ),
          ),
        ],
      ),
    );
  }
}
