import 'package:flutter/material.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/app_localizations.dart';
import 'package:graduation_project/constants.dart';
// Import the generated AppLocalizations class


class LearnViewBody extends StatelessWidget {
  const LearnViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Get the localization instance
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( // No longer const
                    l10n.yourCarbonFootprintTitle, // Localized
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: MyColors.kPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildItem(
                    context,
                    image: AssetsData.questionMark, // Adjusted to match UI icon
                    title: l10n.whatItIsTitle, // Localized
                    description: l10n.whatItIsDescription, // Localized
                  ),
                  const SizedBox(height: 24),
                  _buildItem(
                    context,
                    image: AssetsData.benifits, // Adjusted to match UI icon
                    title: l10n.benefitsTitle, // Localized
                    description: l10n.benefitsDescription, // Localized
                  ),
                  const SizedBox(height: 24),
                  _buildItem(
                    context,
                    image: AssetsData.co2, // Matches UI icon
                    title: l10n.waysToReduceTitle, // Localized
                    description: l10n.waysToReduceDescription, // Localized
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

    return Card(
      elevation: 2,
      color: MyColors.white,
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
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: MyColors.kPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
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
