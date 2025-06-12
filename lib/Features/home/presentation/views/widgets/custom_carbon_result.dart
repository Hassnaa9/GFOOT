import 'package:flutter/material.dart';
import 'package:graduation_project/app_localizations.dart';

class CustomCarbonResult extends StatelessWidget {
  final double? carbonFootprint;
  const CustomCarbonResult({
    super.key,
    this.carbonFootprint,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "CO₂",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xff183309), // Consider making this theme-aware if needed
          ),
        ),
        Text(
          "${carbonFootprint?.toStringAsFixed(2) ?? '0.00'} kg",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          l10n.todayLabel,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}