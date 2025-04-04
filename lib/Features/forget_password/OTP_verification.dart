import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/forget_password/presentation/views/widgets/logo_with_title.dart';
import 'package:graduation_project/Features/forget_password/presentation/views/widgets/otp_form.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit_state.dart';
import 'package:graduation_project/Core/utils/assets.dart';

class VerificationScreen extends StatelessWidget {
  final String route = '/Verify';

  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Assuming email is passed from ForgotPasswordScreen
    final String email = ModalRoute.of(context)?.settings.arguments as String? ?? "";

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthCubit, UserState>(
        listener: (context, state) {
          if (state is SignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMessage)),
            );
          }
        },
        builder: (context, state) {
          return LogoWithTitle(
            logo: AssetsData.otpImg,
            title: 'OTP Verification',
            subText: "Enter the 6-digit code sent to your email",
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              OtpForm(
                onOtpSubmitted: (otp) {
                  context.read<AuthCubit>().verifyOtp(email, otp, context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}