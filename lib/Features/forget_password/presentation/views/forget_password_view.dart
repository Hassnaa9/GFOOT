import 'package:flutter/material.dart';
import 'package:graduation_project/Features/forget_password/presentation/views/widgets/logo_with_title.dart';
import 'package:graduation_project/constants.dart';
import '../../../../Core/utils/assets.dart';

class ForgetPasswordBody extends StatefulWidget {
  const ForgetPasswordBody({super.key});

  @override
  State<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return LogoWithTitle(
      logo: AssetsData.forgotPassImg,
      title: 'Forgot Password?',
      subText:
      "Don’t worry! It happens."
          " Please enter your email address, and we will send the OTP to your phone number.",
      children: [
        Form(
          key: _formKey,
          child: SizedBox(
            width: screenWidth - 44,
            height: screenHeight * .086,
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                filled: true,
                fillColor: Color(0xffE8ECF4),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
          ),
        ),
        SizedBox(height: screenHeight * .04),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pushNamed(context, '/Verify');
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
          child: const Text("Continue"),
        ),
      ],
    );
  }
}
