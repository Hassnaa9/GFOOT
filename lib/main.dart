import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/Core/api/api_consumer.dart';
import 'package:graduation_project/Core/api/dio_consumer.dart';
import 'package:graduation_project/Data/repository/activity_repository.dart';
import 'package:graduation_project/Data/repository/auth_repository.dart';
import 'package:graduation_project/Features/forget_password/change_password.dart';
import 'package:graduation_project/Features/forget_password/forget_password.dart';
import 'package:graduation_project/Features/forget_password/OTP_verification.dart';
import 'package:graduation_project/Features/forget_password/password_changed.dart';
import 'package:graduation_project/Features/home/home.dart';
import 'package:graduation_project/Features/home/learn.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit.dart';
import 'package:graduation_project/Features/home/presentation/views/statistics_view_body.dart';
import 'package:graduation_project/Features/home/rank.dart';
import 'package:graduation_project/Features/home/recommendations.dart';
import 'package:graduation_project/Features/login&registration/login.dart';
import 'package:graduation_project/Features/login&registration/login_or_reg.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit.dart';
import 'package:graduation_project/Features/login&registration/register.dart';
import 'package:graduation_project/Features/profile&setting/account.dart';
import 'package:graduation_project/Features/profile&setting/profile.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        RepositoryProvider<ActivityRepository>( // Add ActivityRepository
          create: (context) =>
              ActivityRepository(apiConsumer: context.read<ApiConsumer>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                HomeCubit(context.read<ActivityRepository>()), // Add HomeCubit
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Your App',
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/SigninOrSignup': (context) => const SigninOrSignupScreen(),
            '/SignIn': (context) => const SignInScreen(),
            '/SignUp': (context) => SignUpScreen(),
            '/ForgetPass': (context) => ForgotPasswordScreen(),
            '/Verify': (context) => const VerificationScreen(),
            '/ChangePass': (context) => const ChangePasswordScreen(),
            '/PassChanged': (context) => PasswordChangedScreen(),
            '/Home': (context) => const Home(),
            '/Calculations': (context) => const Questionnaire(),
            '/Statistics': (context) => const StatisticsViewBody(),
            '/Profile': (context) => const Profile(),
            '/Account': (context) => const Account(),
            '/Rank': (context) => const Rank(),
            '/Learn': (context) => const Learn(),
            '/Recommendations': (context) => const Recommendations(),
          },
        ),
      ),
    );
  }
}