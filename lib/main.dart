import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Import for global localizations

import 'package:graduation_project/Core/api/api_consumer.dart';
import 'package:graduation_project/Core/api/dio_consumer.dart';
import 'package:graduation_project/Data/local/local_cubit.dart';
import 'package:graduation_project/Data/repository/activity_repository.dart';
import 'package:graduation_project/Data/repository/auth_repository.dart';
import 'package:graduation_project/Features/forget_password/change_password.dart';
import 'package:graduation_project/Features/forget_password/forget_password.dart';
import 'package:graduation_project/Features/forget_password/OTP_verification.dart';
import 'package:graduation_project/Features/forget_password/password_changed.dart';
import 'package:graduation_project/Features/home/learn.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit.dart';
import 'package:graduation_project/Features/home/presentation/views/statistics_view_body.dart';
import 'package:graduation_project/Features/home/rank.dart';
import 'package:graduation_project/Features/home/recommendations.dart';
import 'package:graduation_project/Features/login&registration/confirm_email.dart';
import 'package:graduation_project/Features/login&registration/login.dart';
import 'package:graduation_project/Features/login&registration/login_or_reg.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit.dart';
import 'package:graduation_project/Features/login&registration/register.dart';
import 'package:graduation_project/Features/profile&setting/account.dart';
import 'package:graduation_project/Features/profile&setting/notifications.dart';
import 'package:graduation_project/Features/profile&setting/profile.dart';
import 'package:graduation_project/Features/profile&setting/setting.dart';
import 'package:graduation_project/Features/questionnaire/questionnaire.dart';
import 'package:graduation_project/Features/splash_screen/splash_screen.dart';
import 'package:graduation_project/app_localizations.dart';
import 'package:graduation_project/app_scaffold.dart';
import 'package:graduation_project/theme/app_themes.dart'; // Import your themes
import 'package:graduation_project/theme/theme_cubit.dart'; // Import your ThemeCubit


// Define RouteObserver for RouteAware
final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Keep this for Firebase initialization if needed
  try {
    await Firebase.initializeApp();
    print("Firebase initialized successfully");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  runApp(
    // Provide both LocaleCubit and ThemeCubit at the top of the widget tree
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(create: (context) => ThemeCubit()), // ThemeCubit no longer uses SharedPreferences
      ],
      child: const MyApp(),
    ),
  );
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
        RepositoryProvider<ActivityRepository>(
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
                HomeCubit(context.read<ActivityRepository>()),
          ),
        ],
        // Use BlocBuilder for both LocaleCubit and ThemeCubit
        child: BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, localeState) {
            return BlocBuilder<ThemeCubit, ThemeState>( // BlocBuilder for theme
              builder: (context, themeState) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: AppThemes.lightTheme, // Default light theme
                  darkTheme: AppThemes.darkTheme, // Default dark theme
                  themeMode: themeState.themeMode, // Controlled by ThemeCubit
                  onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
                  initialRoute: '/',
                  navigatorObservers: [routeObserver],
                  locale: localeState.locale,
                  supportedLocales: AppLocalizations.supportedLocales,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  localeResolutionCallback: (locale, supportedLocales) {
                    if (locale != null) {
                      for (var supportedLocale in supportedLocales) {
                        if (supportedLocale.languageCode == locale.languageCode) {
                          return supportedLocale;
                        }
                      }
                    }
                    return supportedLocales.first;
                  },
                  routes: {
                    '/': (context) => const SplashScreen(),
                    '/SigninOrSignup': (context) => const SigninOrSignupScreen(),
                    '/SignIn': (context) => const SignInScreen(),
                    '/SignUp': (context) => SignUpScreen(),
                    '/ForgetPass': (context) => ForgotPasswordScreen(),
                    '/Verify': (context) => const VerificationScreen(),
                    '/ChangePass': (context) => const ChangePasswordScreen(),
                    '/PassChanged': (context) => PasswordChangedScreen(),
                    '/Home': (context) => const AppScaffold(),
                    '/Calculations': (context) => const Questionnaire(),
                    '/Statistics': (context) => const StatisticsViewBody(),
                    '/Profile': (context) => const Profile(),
                    '/Account': (context) => const Account(),
                    '/Rank': (context) => const Rank(),
                    '/Learn': (context) => const Learn(),
                    '/Settings': (context) => const Setting(),
                    '/Notifications': (context) => const Notifications(),
                    '/Recommendations': (context) => const Recommendations(),
                    '/ConfirmEmail': (context) => const ConfirmEmail(),
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}