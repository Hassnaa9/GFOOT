import 'package:flutter/material.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/constants.dart';

class LearnViewBody extends StatelessWidget {
  const LearnViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    ' Carbon Footprint',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: MyColors.kPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildItem(
                    context,
                    image: AssetsData.what_its_this,
                    title: 'What It Is?',
                    description:
                        'Your Carbon footprint is the total amount of greenhouse gases you cause, including carbon dioxide and methane.',
                  ),
                  const SizedBox(height: 20),
                  _buildItem(
                    context,
                    image: AssetsData.benifits,
                    title: 'Benefits of Reducing',
                    description:
                        'Reducing your carbon footprint helps to slow climate change, conserve natural resources, and create a more sustainable future.',
                  ),
                  const SizedBox(height: 20),
                  _buildItem(
                    context,
                    image: AssetsData.co2,
                    title: 'Ways to Reduce',
                    description:
                        'You can lower your footprint by saving energy, reducing waste, choosing sustainable transportation, and supporting eco-friendly products.',
                  ),
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

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          image,
          height: imageSize,
          width: imageSize,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
