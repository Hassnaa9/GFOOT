import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit_state.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/rank_card.dart';
import 'package:graduation_project/app_localizations.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/Core/models/user_model.dart';
// Import the generated AppLocalizations class

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

    context.read<HomeCubit>().fetchRanks(); // Triggers user profile fetch if needed
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the localization instance
    final l10n = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      appBar: AppBar(
        title: Text(l10n.rankTitle, style: const TextStyle(color: Colors.black)), // Localized
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            print('RankViewBody: Current state: ${state.runtimeType}');
            UserModel? user;
            bool isProfileLoading = false;
            String? profileError;

            if (state is HomeProfileLoaded) {
              user = state.user;
            } else if (state is HomeRanksLoaded) {
              user = state.user; // Now correctly accesses the user field
            } else if (state is HomeLoading) {
              isProfileLoading = true;
            } else if (state is HomeError && state.errorMessage.contains('user profile')) {
              profileError = state.errorMessage;
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    children: [
                      if (state is HomeLoading && !isProfileLoading)
                        const Center(child: CircularProgressIndicator(color: MyColors.kPrimaryColor))
                      else if (state is HomeRanksLoaded)
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                const CircleAvatar(
                                  radius: 60,
                                  backgroundImage: AssetImage(AssetsData.echoF),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: MyColors.kPrimaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${state.rank.cityRank}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                if (isProfileLoading)
                                  Text( // No longer const
                                    l10n.loadingUser, // Localized
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
                                  )
                                else if (profileError != null)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text( // No longer const
                                        l10n.failedToLoadUser, // Localized
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red),
                                      ),
                                      TextButton(
                                        onPressed: () => context.read<HomeCubit>().fetchUserProfile(),
                                        child: Text(l10n.retryButton, style: const TextStyle(color: MyColors.kPrimaryColor)), // Localized
                                      ),
                                    ],
                                  )
                                else
                                  Text(
                                    user?.displayName ?? user?.userName ?? l10n.userNamePlaceholder, // Localized
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                const SizedBox(height: 32),
                                BuildRankCard(
                                  imagePath: AssetsData.cityRank,
                                  title: l10n.cityRankTitle, // Localized
                                  rank: state.rank.cityRank,
                                ),
                                const SizedBox(height: 16),
                                BuildRankCard(
                                  imagePath: AssetsData.countryRank,
                                  title: l10n.countryRankTitle, // Localized
                                  rank: state.rank.countryRank,
                                ),
                                const SizedBox(height: 16),
                                BuildRankCard(
                                  imagePath: AssetsData.globalRank,
                                  title: l10n.globalRankTitle, // Localized
                                  rank: state.rank.globalRank,
                                ),
                              ],
                            ),
                          ),
                        )
                      else if (state is HomeError)
                        Column(
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
                              child: Text(l10n.retryButton), // Localized
                            ),
                          ],
                        )
                      else
                        Center( // No longer const
                          child: Text(
                            l10n.noRankingsAvailable, // Localized
                            style: const TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
