import 'package:flutter/material.dart';
import 'package:graduation_project/Features/splash_screen/presentation/views/widgets/splash_custom_button.dart';
import '../../../../Core/utils/assets.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Fade animation for logo
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    // Slide animation for button
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    // Start animation
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
          // Background Image
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                child: Image.asset(AssetsData.splashImg),
              ),
            ),
          ),
          // Animated Logo
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: FractionallySizedBox(
                alignment: Alignment.center,
                child: Image.asset(
                  AssetsData.logo,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // Animated Button
          Positioned(
            bottom: screenHeight * 0.02,
            left: screenWidth * 0.45,
            child: SlideTransition(
              position: _slideAnimation,
              child: Center(
                child: CustomSwipeButton(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth, // Fixed: was using screenHeight twice
                ),
              ),
            ),
          ),
        ],
      );
  }
}