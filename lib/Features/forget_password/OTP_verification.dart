import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/forget_password/presentation/views/widgets/logo_with_title.dart';
import 'package:graduation_project/Features/forget_password/presentation/views/widgets/otp_form.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit_state.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/constants.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
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
          } else if (state is OtpStored) {
            print('OtpStored state received, navigating to /ChangePassword'); // Debug print
            Navigator.pushNamed(context, '/ChangePass', arguments: email);
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
                  print('OTP Submitted: $otp'); // Debug print
                  context.read<AuthCubit>().storeOtp(otp); // Store OTP and trigger navigation
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
                            context.read<AuthCubit>().resendOtp(email, context);
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