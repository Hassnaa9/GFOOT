import 'package:flutter/material.dart';
import 'package:graduation_project/Features/forget_password/presentation/views/widgets/logo_with_title.dart';
import '../../Core/utils/assets.dart';
import '../../constants.dart';

class PasswordChangedScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  PasswordChangedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: LogoWithTitle(
        logo: AssetsData.jumpImg,
        title: "Password Changed!",
        subText: "Your password has been changed successfully!",
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*.03,),
          ElevatedButton(
            onPressed: () {
              if (true) {
                Navigator.pushReplacementNamed(context, '/SignIn');
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
            child: const Text("Back to Login"),
          ),
        ],
      ),
    );
  }
}