import 'package:flutter/material.dart';
import 'package:graduation_project/Features/login&registration/presentation/views/login_or_reg_view_body.dart';

class CustomSwipeButton extends StatelessWidget {
  final double screenWidth,screenHeight;
  const CustomSwipeButton( {super.key, required this.screenHeight,required this.screenWidth});

  @override
  Widget build(BuildContext context) {
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
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_upward,
                color: Colors.white,
                size: 25,
              ),
              SizedBox(height: 10),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Text(
                  "GO",
                  style: TextStyle(
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