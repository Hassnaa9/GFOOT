import 'package:flutter/material.dart';
import 'package:graduation_project/Features/login&registration/presentation/views/login_or_reg_view_body.dart';
// Import the generated AppLocalizations class
import 'package:graduation_project/app_localizations.dart';


class CustomSwipeButton extends StatelessWidget {
  final double screenWidth,screenHeight;
  const CustomSwipeButton( {super.key, required this.screenHeight,required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    // Get the localization instance
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginOrRegBody(),
            ),
          );
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: .2*screenHeight,
            width: .16*screenWidth,
            decoration: BoxDecoration(
              color: const Color(0x44FBFBF7),
              borderRadius: BorderRadius.circular(43),
            ),
          ),
          // Removed 'const' keyword because Text widget is no longer constant
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon( // Icon itself can remain const
                Icons.arrow_upward,
                color: Colors.white,
                size: 25,
              ),
              const SizedBox(height: 10),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Text(
                  "GO", // This is an icon, not a localized string. Kept as is.
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
