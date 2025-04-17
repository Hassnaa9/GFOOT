import 'package:flutter/material.dart';

class CustomCarbonResult extends StatelessWidget {
  final double? carbonFootprint;
  const CustomCarbonResult({
    super.key, this.carbonFootprint,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          "${carbonFootprint?.toStringAsFixed(2) ?? '0.00'} kg",
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
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600]),
        ),
      ],
    );
  }
}
