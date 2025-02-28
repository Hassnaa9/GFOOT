import 'package:flutter/material.dart';
import 'package:graduation_project/Features/forget_password/presentation/views/widgets/logo_with_title.dart';
import 'package:graduation_project/Features/forget_password/presentation/views/widgets/otp_form.dart';
import '../../Core/utils/assets.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});
  final String route = '/Verify';

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LogoWithTitle(
        logo: AssetsData.otpImg,
        title: 'OTP Verification',
        subText: "Enter the verification code we just sent on your email address",
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          // OTP Form
          const OtpForm(),
        ],
      ),
    );
  }
}





