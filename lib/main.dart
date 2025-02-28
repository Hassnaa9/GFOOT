import 'package:flutter/material.dart';
import 'package:graduation_project/Features/forget_password/OTP_verification.dart';
import 'package:graduation_project/Features/forget_password/change_password.dart';
import 'package:graduation_project/Features/home/home.dart';
import 'package:graduation_project/Features/questionnaire/questionnaire.dart';
import 'Features/forget_password/forget_password.dart';
import 'Features/forget_password/password_changed.dart';
import 'Features/login&registration/login.dart';
import 'Features/login&registration/login_or_reg.dart';
import 'Features/login&registration/register.dart';
import 'Features/splash_screen/splash_screen.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Define the routes   here
      routes: {
        '/': (context) => const SplashScreen(), // Set SplashScreen as the initial route
        '/SigninOrSignup': (context) => const SigninOrSignupScreen(),
        '/SignIn' : (context) => const SignInScreen(),
        '/SignUp' : (context) => SignUpScreen(),
        '/ForgetPass' : (context) => ForgotPasswordScreen(),
        '/Verify' : (context) => const VerificationScreen(),
        '/ChangePass' : (context) => const ChangePasswordScreen(),
        '/PassChanged' : (context) => PasswordChangedScreen(),
        '/Home' : (context) => const Home(),
        '/Calculations' : (context) => const Questionnaire()

      },
    );
  }
}