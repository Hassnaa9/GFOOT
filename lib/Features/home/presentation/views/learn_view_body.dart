import 'package:flutter/material.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/app_localizations.dart';

class LearnViewBody extends StatelessWidget {
  const LearnViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context); // Access theme data

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // Theme-aware background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.yourCarbonFootprintTitle,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary, // Theme-aware primary color
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildItem(
                    context,
                    image: AssetsData.questionMark,
                    title: l10n.whatItIsTitle,
                    description: l10n.whatItIsDescription,
                  ),
                  const SizedBox(height: 24),
                  _buildItem(
                    context,
                    image: AssetsData.benifits,
                    title: l10n.benefitsTitle,
                    description: l10n.benefitsDescription,
                  ),
                  const SizedBox(height: 24),
                  _buildItem(
                    context,
                    image: AssetsData.co2,
                    title: l10n.waysToReduceTitle,
                    description: l10n.waysToReduceDescription,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required String image,
    required String title,
    required String description,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = screenWidth < 400 ? 60.0 : 80.0;
    final theme = Theme.of(context); // Access theme data

    return Card(
      elevation: 2,
      // color: theme.cardTheme.color, // Theme-aware card color
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              image,
              height: imageSize,
              width: imageSize,
              // color: theme.colorScheme.onSurface, // Theme-aware image tint
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.primary, // Theme-aware primary color
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 15,
                      color: theme.colorScheme.onSurface, // Theme-aware text color
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}