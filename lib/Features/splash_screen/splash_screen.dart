import 'package:flutter/material.dart';
import 'package:graduation_project/Features/splash_screen/presentation/views/splash_view_body.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashViewBody()
    );
  }

}
