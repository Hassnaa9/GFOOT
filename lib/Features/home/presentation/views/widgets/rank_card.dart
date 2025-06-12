import 'package:flutter/material.dart';

Widget BuildRankCard({
  required String imagePath,
  required String title,
  required int rank,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final screenWidth = MediaQuery.of(context).size.width;
      final isSmall = screenWidth < 350;

      return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.06,
          vertical: screenWidth * 0.08,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.surface, // Changed from Colors.white
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withOpacity(0.12), // Changed from Colors.black12
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: isSmall ? 22 : 28,
              height: isSmall ? 22 : 28,
            ),
            SizedBox(width: isSmall ? 8 : 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: isSmall ? 14 : 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface, // Ensures text color is theme-aware
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isSmall ? 8 : 12,
                vertical: isSmall ? 6 : 8,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer, // Changed from Colors.green[100]
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '#$rank',
                style: TextStyle(
                  fontSize: isSmall ? 14 : 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary, // Changed from Colors.green
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}