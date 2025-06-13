import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit_state.dart';
import 'package:graduation_project/Features/login&registration/presentation/views/widgets/login_methods.dart';
import 'package:graduation_project/app_localizations.dart';
import 'package:graduation_project/constants.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Google Sign-In
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart'; // Facebook Auth


class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // Initialize Google Sign-In and Firebase Auth
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Google Sign-In Method
  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // User cancelled the sign-in

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      context.read<AuthCubit>().signInWithGoogle(userCredential.user!);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In Failed: $e')), // Kept for error message clarity
      );
    }
  }

  // Facebook Sign-In Method
  Future<void> _signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        context.read<AuthCubit>().signInWithFacebook(userCredential.user!);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Facebook Sign-In Failed: ${result.message}')), // Kept for error message clarity
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Facebook Sign-In Failed: $e')), // Kept for error message clarity
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context); // Access theme data
    // Get the localization instance
    final l10n = AppLocalizations.of(context)!;

    return Container(
      color: theme.scaffoldBackgroundColor, // Theme-aware background
      child: SafeArea(
        
        child: SingleChildScrollView(
          
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  .06 * screenWidth,
                  .1 * screenHeight,
                  0,
                  10,
                ),
                child: Text(
                  l10n.welcomeBackMessage, // Localized
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: screenWidth * .07,
                    fontWeight: FontWeight.bold,
      
                  ),
                ),
              ),
              SizedBox(height: screenHeight * .02),
              BlocProvider(
                // The `create` callback here was causing issues as it was redundant
                // and potentially creating a new cubit instance. Removed it and
                // kept only BlocBuilder, as BlocProvider should ideally be higher up.
                // If you need to scope AuthCubit specifically to this widget,
                // reconsider the architecture or ensure it's not double-provided.
                // Assuming it's already provided higher up.
                create: (context) => AuthCubit(context.read()), // Retained from original, but consider higher-level provision
                child: BlocBuilder<AuthCubit, UserState>(
                  builder: (context, state) {
                    if (state is SignInLoading) {
                      return const Center(child: CircularProgressIndicator(color: MyColors.kPrimaryColor,));
                    }
                    if (state is SignInFailure) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errMessage)),
                        );
                      });
                    }
                    if (state is SignInSuccess) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushReplacementNamed(context, '/Home');
                      });
                    }
      
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            width: screenWidth - 44,
                            height: screenHeight * .086,
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration( // No longer const
                                hintText: l10n.enterYourEmailHint, // Localized
                                filled: true,
                                fillColor: const Color(0xffE8ECF4),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(Radius.circular(9)),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return l10n.enterYourEmailHint; // Localized
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  return l10n.enterValidEmail; // Localized (added to ARB)
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: screenHeight * .02),
                          SizedBox(
                            width: screenWidth - 44,
                            height: screenHeight * .086,
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              decoration: InputDecoration( // No longer const
                                hintText: l10n.enterYourPasswordHint, // Localized
                                filled: true,
                                fillColor: const Color(0xffE8ECF4),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(Radius.circular(9)),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return l10n.enterYourPasswordHint; // Localized
                                }
                                if (value.length < 8) {
                                  return l10n.passwordMinLength; // Localized (added to ARB)
                                }
                                return null;
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/ForgetPass');
                              },
                              child: Text(
                                l10n.forgotPasswordTitle, // Localized
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.grey.shade600),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * .02),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                context.read<AuthCubit>().login(
                                      _emailController.text,
                                      _passwordController.text,
                                    );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: MyColors.kPrimaryColor,
                              foregroundColor: MyColors.white,
                              minimumSize: Size(screenWidth - 44, screenHeight * .086),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                            child: Text(l10n.loginButton), // Localized
                          ),
                          SizedBox(height: screenHeight * .02),
                          Row( // No longer const
                            children: [
                              const Expanded( // Can remain const
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  l10n.orLoginWith, // Localized
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                              const Expanded( // Can remain const
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenWidth * .02),
                          login_methods(
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                            onGoogleTap: _signInWithGoogle, // Pass Google callback
                            onFacebookTap: _signInWithFacebook, // Pass Facebook callback
                          ),
                          SizedBox(height: screenHeight * .17),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/SignUp');
                            },
                            child: Text.rich(
                              TextSpan( // No longer const
                                text: l10n.dontHaveAccount, // Localized
                                children: [
                                  TextSpan(
                                    text: l10n.registerNowLink, // Localized
                                    style: const TextStyle(color: MyColors.kPrimaryColor),
                                  ),
                                ],
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.grey.shade600),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
