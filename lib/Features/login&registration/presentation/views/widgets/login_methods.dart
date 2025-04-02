import 'package:flutter/material.dart';
import 'package:graduation_project/Features/login&registration/presentation/views/widgets/Social_Icon_button.dart';
import 'package:graduation_project/Core/utils/assets.dart';

class login_methods extends StatelessWidget {
  final double screenWidth, screenHeight;
  final VoidCallback? onGoogleTap; // Callback for Google login
  final VoidCallback? onFacebookTap; // Callback for Facebook login

  const login_methods({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    this.onGoogleTap,
    this.onFacebookTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SocialSignInButton(
            iconPath: AssetsData.facebook,
            width: screenWidth * .6,
            onPressed: onFacebookTap ?? () {}, // Use Facebook callback
          ),
        ),
        Expanded(
          child: SocialSignInButton(
            iconPath: AssetsData.google,
            width: screenWidth * .6,
            onPressed: onGoogleTap ?? () {}, // Use Google callback
          ),
        ),
        Expanded(
          child: SocialSignInButton(
            iconPath: AssetsData.apple,
            width: screenWidth * .6,
            onPressed: () {
              // Apple sign-in action (not implemented here)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Apple Sign-In not implemented')),
              );
            },
          ),
        ),
      ],
    );
  }
}