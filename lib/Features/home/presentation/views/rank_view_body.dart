import 'package:flutter/material.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/rank_card.dart';
import 'package:graduation_project/constants.dart';

class RankViewBody extends StatelessWidget {
  const RankViewBody({super.key, required int cityRank, required int countryRank, required int globalRank});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage(AssetsData.otpImg),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: MyColors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '1',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Hassnaa Mohamed',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 32),

              // Cards
              BuildRankCard(
                imagePath: AssetsData.cityRank, // Replace with your image path
                title: 'City Rank',
                rank: 5,
              ),
              const SizedBox(height: 16),
              BuildRankCard(
                imagePath: AssetsData.countryRank, // Replace with your image path
                title: 'Country Rank',
                rank: 12,
              ),
              const SizedBox(height: 16),
              BuildRankCard(
                imagePath: AssetsData.globalRank, // Replace with your image path
                title: 'Global Rank',
                rank: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

}