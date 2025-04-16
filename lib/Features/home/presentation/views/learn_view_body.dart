import 'package:flutter/material.dart';
import 'package:graduation_project/Core/utils/assets.dart';

class LearnViewBody extends StatelessWidget {
  const LearnViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Carbon\nFootprint',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              _buildItem(
                image: AssetsData.what_its_this,
                title: 'What It Is?\n',
                description:
                    'Your Carbon footprint is the total amount of greenhouse gases you cause, including carbon dioxide and methane.',
              ),
              const SizedBox(height: 60),
              _buildItem(
                image: AssetsData.benifits,
                title: 'Benefits of Reducing\n',
                description:
                    'Reducing your carbon footprint helps to slow climate change, conserve natural resources, and create a more sustainable future.',
              ),
              const SizedBox(height: 60),
              _buildItem(
                image: AssetsData.co2,
                title: 'Ways to Reduce\n',
                description:
                    'You can lower your footprint by saving energy, reducing waste, choosing sustainable transportation, and supporting eco-friendly products.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem({
    required String image,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          image,
          height: 80,
          width: 80,
        ),
        const SizedBox(width: 27),
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
              const SizedBox(height: 4),
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
