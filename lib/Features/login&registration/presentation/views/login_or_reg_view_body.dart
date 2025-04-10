import 'package:flutter/material.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/constants.dart';

class LoginOrRegBody extends StatefulWidget {
  const LoginOrRegBody({super.key});

  @override
  State<LoginOrRegBody> createState() => _LoginOrRegBodyState();
}

class _LoginOrRegBodyState extends State<LoginOrRegBody> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _buttonSlideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Fade animation for logo
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    // Scale animation for logo
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    // Slide animation for buttons
    _buttonSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          AssetsData.logOrRegImg,
          fit: BoxFit.fill,
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Spacer(flex: (screenHeight * .0039).toInt()),
                Expanded(
                  flex: 10,
                  child: Center(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: FractionallySizedBox(
                          widthFactor: screenWidth * .5,
                          alignment: Alignment.center,
                          child: Image.asset(
                            AssetsData.logo,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(flex: (screenHeight * .01).toInt()),
                SlideTransition(
                  position: _buttonSlideAnimation,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/SignIn');
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 40,
                      backgroundColor: MyColors.kPrimaryColor,
                      foregroundColor: MyColors.white,
                      minimumSize: Size(screenWidth - 44, screenHeight * .086),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    child: const Text("Sign In"),
                  ),
                ),
                SizedBox(height: screenHeight * .02),
                SlideTransition(
                  position: _buttonSlideAnimation,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/SignUp');
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 40,
                      foregroundColor: MyColors.black,
                      minimumSize: Size(screenWidth - 44, screenHeight * .086),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      backgroundColor: MyColors.white,
                    ),
                    child: const Text("Sign Up"),
                  ),
                ),
                Spacer(flex: (screenHeight * .0039).toInt()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}