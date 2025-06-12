import 'package:flutter/material.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/constants.dart';

class LearnViewBody extends StatelessWidget {
  const LearnViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                  const Text(
                    'Your Carbon Footprint',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: MyColors.kPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildItem(
                    context,
                    image: AssetsData.questionMark, // Adjusted to match UI icon
                    title: 'What It Is',
                    description:
                        'Your Carbon Footprint is the total amount of greenhouse gases you produce, including carbon dioxide and methane.',
                  ),
                  const SizedBox(height: 24),
                  _buildItem(
                    context,
                    image: AssetsData.benifits, // Adjusted to match UI icon
                    title: 'Benefits',
                    description:
                        'Reducing your Carbon Footprint helps to slow climate change, conserve natural resources, and create a more sustainable future.',
                  ),
                  const SizedBox(height: 24),
                  _buildItem(
                    context,
                    image: AssetsData.co2, // Matches UI icon
                    title: 'Ways to Reduce',
                    description:
                        'You can lower your footprint by saving energy, reducing waste, choosing sustainable transportation, and supporting eco-friendly products.',
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