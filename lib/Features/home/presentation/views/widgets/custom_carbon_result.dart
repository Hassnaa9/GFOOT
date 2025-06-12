import 'package:flutter/material.dart';
import 'package:graduation_project/app_localizations.dart';
import 'package:graduation_project/constants.dart';

class CustomCarbonResult extends StatelessWidget {
  final double? carbonFootprint;
  const CustomCarbonResult({
    super.key, this.carbonFootprint,

  });

  @override
  Widget build(BuildContext context) {
    // Get the localization instance
    final l10n = AppLocalizations.of(context)!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text( // Kept as const as CO2 is a scientific symbol
          "CO₂",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xff183309),
          ),
        ),
        Text( // No longer const
          "${carbonFootprint?.toStringAsFixed(2) ?? '0.00'} kg",
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: MyColors.kPrimaryColor,)
        ),
        const SizedBox(
          height: 6,
        ),
        Text( // No longer const
          l10n.todayLabel, // Localized
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey[700]),
        ),
      ],
    );
  }
}
