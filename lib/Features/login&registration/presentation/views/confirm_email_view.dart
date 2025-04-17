import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/forget_password/presentation/views/widgets/logo_with_title.dart';
import 'package:graduation_project/Features/forget_password/presentation/views/widgets/otp_form.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit_state.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/constants.dart';

class ConfirmEmailViewBody extends StatefulWidget {
  const ConfirmEmailViewBody({super.key});

  @override
  State<ConfirmEmailViewBody> createState() => _ConfirmEmailViewBodyState();
}

class _ConfirmEmailViewBodyState extends State<ConfirmEmailViewBody> {
  int _resendCooldown = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      _resendCooldown = 60; // 60 seconds cooldown
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCooldown > 0) {
        setState(() {
          _resendCooldown--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)?.settings.arguments as String? ?? "";

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthCubit, UserState>(
        listener: (context, state) {
          if (state is SignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMessage)),
            );
          } else if (state is OtpVerificationSuccess) {
            print('OTP verification successful, navigating to /SignIn'); // Debug print
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Email verified successfully!')),
            );
            Navigator.pushReplacementNamed(context, '/SignIn');
          } else if (state is OtpVerificationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMessage)),
            );
          } else if (state is ForgotPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('OTP resent successfully')),
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
  if (otp.length == 6 && RegExp(r'^\d{6}$').hasMatch(otp)) {
    context.read<AuthCubit>().verifyConfirmEmailOtp(email, otp);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter a valid 6-digit OTP')),
    );
  }
},
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn’t receive the OTP? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: _resendCooldown > 0 || state is SignInLoading
                        ? null
                        : () {
                            print('Resending OTP for email: $email'); // Debug print
                            context.read<AuthCubit>().resendResetConfirmEmailOtp(email, context);
                            _startResendTimer();
                          },
                    child: Text(
                      _resendCooldown > 0
                          ? "Resend OTP ($_resendCooldown s)"
                          : "Resend OTP",
                      style: TextStyle(
                        color: _resendCooldown > 0 || state is SignInLoading
                            ? Colors.grey
                            : MyColors.kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}