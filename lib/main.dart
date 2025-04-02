import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/Core/api/api_consumer.dart';
import 'package:graduation_project/Core/api/dio_consumer.dart';
import 'package:graduation_project/Data/repository/auth_repository.dart';
import 'package:graduation_project/Features/forget_password/change_password.dart';
import 'package:graduation_project/Features/forget_password/forget_password.dart';
import 'package:graduation_project/Features/forget_password/OTP_verification.dart';
import 'package:graduation_project/Features/forget_password/password_changed.dart';
import 'package:graduation_project/Features/home/home.dart';
import 'package:graduation_project/Features/login&registration/login.dart';
import 'package:graduation_project/Features/login&registration/login_or_reg.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit.dart';
import 'package:graduation_project/Features/login&registration/register.dart';
import 'package:graduation_project/Features/questionnaire/questionnaire.dart';
import 'package:graduation_project/Features/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print("Firebase initialized successfully");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Dio>(
          create: (_) => Dio(),
          dispose: (dio) => dio.close(),
        ),
        RepositoryProvider<ApiConsumer>(
          create: (context) => DioConsumer(dio: context.read<Dio>()),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) =>
              AuthRepository(apiConsumer: context.read<ApiConsumer>()),
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthCubit(context.read<AuthRepository>()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Your App',
          // Define the routes here
          initialRoute: '/', // Set SplashScreen as the initial route
          routes: {
            '/': (context) => const SplashScreen(), // Set SplashScreen as the initial route
            '/SigninOrSignup': (context) => const SigninOrSignupScreen(),
            '/SignIn': (context) => const SignInScreen(),
            '/SignUp': (context) => SignUpScreen(),
            '/ForgetPass': (context) => ForgotPasswordScreen(),
            '/Verify': (context) => const VerificationScreen(),
            '/ChangePass': (context) => const ChangePasswordScreen(),
            '/PassChanged': (context) => PasswordChangedScreen(),
            '/Home': (context) => const Home(),
            '/Calculations': (context) => const Questionnaire()
          },
        ),
      ),
    );
  }
}
