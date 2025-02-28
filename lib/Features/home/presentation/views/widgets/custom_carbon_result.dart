import 'package:flutter/material.dart';

class CustomCarbonResult extends StatelessWidget {
  const CustomCarbonResult({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "CO₂",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xff183309),
          ),
        ),
        Text(
          "148kg",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff58b698)),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          "Today",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff153f33)),
        ),
      ],
    );
  }
}
