import 'package:flutter/material.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/Features/profile&setting/presentation/views/widgets/profile_menu.dart';
import 'package:graduation_project/Features/profile&setting/presentation/views/widgets/profile_pic.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            Text("Hassnaa Mohamed",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff1A1A1A),
                    )),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "Edit My Account",
              icon: AssetsData.user,
              press: () => {
                Navigator.pushNamed(context, "/Account"),
              },
            ),
            ProfileMenu(
              text: "Notifications",
              icon: AssetsData.bell,
              press: () {
                Navigator.pushNamed(context, "/Notifications");
              },
            ),
            ProfileMenu(
              text: "Settings",
              icon: AssetsData.settings,
              press: () {
                Navigator.pushNamed(context, "/Settings");
              },
            ),
            ProfileMenu(
              text: "Help Center",
              icon: AssetsData.questionMark,
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: AssetsData.logout,
              press: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/SignIn',
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


