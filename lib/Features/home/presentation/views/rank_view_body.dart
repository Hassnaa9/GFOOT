import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit_state.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/rank_card.dart';
import 'package:graduation_project/constants.dart';

class RankViewBody extends StatefulWidget {
  const RankViewBody({super.key});

  @override
  State<RankViewBody> createState() => _RankViewBodyState();
}

class _RankViewBodyState extends State<RankViewBody> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    context.read<HomeCubit>().fetchRanks();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeRanksLoaded) {
              final rank = state.rank;

              return FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            const CircleAvatar(
                              radius: 60,
                              backgroundImage: AssetImage(AssetsData.otpImg),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                              decoration: BoxDecoration(
                                color: MyColors.kPrimaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${rank.cityRank}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Hassnaa Mohamed',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 32),

                            // Rank Cards
                            BuildRankCard(
                              imagePath: AssetsData.cityRank,
                              title: 'City Rank',
                              rank: rank.cityRank,
                            ),
                            const SizedBox(height: 16),
                            BuildRankCard(
                              imagePath: AssetsData.countryRank,
                              title: 'Country Rank',
                              rank: rank.countryRank,
                            ),
                            const SizedBox(height: 16),
                            BuildRankCard(
                              imagePath: AssetsData.globalRank,
                              title: 'Global Rank',
                              rank: rank.globalRank,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        context.read<HomeCubit>().fetchRanks();
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: MyColors.kPrimaryColor),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            return const Center(
              child: Text(
                "No Rankings Available",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          },
        ),
      ),
    );
  }
}
