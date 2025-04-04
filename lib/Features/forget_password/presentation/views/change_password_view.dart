import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/forget_password/presentation/views/widgets/logo_with_title.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit_state.dart';
import 'package:graduation_project/constants.dart';
import '../../../../Core/utils/assets.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  _ChangePasswordBodyState createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final String email = ModalRoute.of(context)?.settings.arguments as String? ?? "";
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<AuthCubit, UserState>(
      listener: (context, state) {
        if (state is SignInFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
        } else if (state is SignInSuccess) {
          Navigator.pushReplacementNamed(context, '/PassChanged');
        }
      },
      builder: (context, state) {
        return LogoWithTitle(
          logo: AssetsData.forgotPassImg,
          title: 'Create New Password',
          subText: 'Your new password must be unique from those previously used!',
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: screenWidth - 44,
                    height: screenHeight * .086,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        filled: true,
                        fillColor: const Color(0xffE8ECF4),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() => _isPasswordVisible = !_isPasswordVisible);
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  SizedBox(
                    width: screenWidth - 44,
                    height: screenHeight * .086,
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Confirm your password',
                        filled: true,
                        fillColor: const Color(0xffE8ECF4),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() => _isPasswordVisible = !_isPasswordVisible);
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            ElevatedButton(
              onPressed: state is SignInLoading
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().resetPassword(
                              email,
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
              child: state is SignInLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Reset Password"),
            ),
          ],
        );
      },
    );
  }
}