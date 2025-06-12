import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit_state.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/rank_card.dart';
import 'package:graduation_project/app_localizations.dart';
import 'package:graduation_project/Core/models/user_model.dart';

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

    // Fetch ranks when the widget initializes
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
    final l10n = AppLocalizations.of(context)!; // Localization instance
    final theme = Theme.of(context); // Theme instance for theme-aware colors

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // Theme-aware background
      appBar: AppBar(
        title: Text(
          l10n.rankTitle,
          style: theme.appBarTheme.titleTextStyle ?? TextStyle(
            color: theme.colorScheme.onBackground, // Fallback to onBackground
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor, // Theme-aware AppBar background
        elevation: theme.appBarTheme.elevation ?? 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.appBarTheme.iconTheme?.color ?? theme.colorScheme.onBackground, // Theme-aware icon color
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            print('RankViewBody: Current state: ${state.runtimeType}');
            UserModel? user;
            bool isProfileLoading = false;
            String? profileError;

            // Handle different states from HomeCubit
            if (state is HomeProfileLoaded) {
              user = state.user;
            } else if (state is HomeRanksLoaded) {
              user = state.user;
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
                        Center(
                          child: CircularProgressIndicator(
                            color: theme.colorScheme.primary, // Theme-aware indicator color
                          ),
                        )
                      else if (state is HomeRanksLoaded)
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                CircleAvatar(
                                  radius: 60,
                                  backgroundImage: const AssetImage(AssetsData.echoF),
                                  backgroundColor: theme.colorScheme.surface, // Theme-aware fallback background
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary, // Theme-aware container color
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${state.rank.cityRank}',
                                    style: TextStyle(
                                      color: theme.colorScheme.onPrimary, // Theme-aware text color
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                if (isProfileLoading)
                                  Text(
                                    l10n.loadingUser,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: theme.colorScheme.onSurface.withOpacity(0.6), // Subtle text color
                                    ),
                                  )
                                else if (profileError != null)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        l10n.failedToLoadUser,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: theme.colorScheme.error, // Theme-aware error color
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () => context.read<HomeCubit>().fetchUserProfile(),
                                        child: Text(
                                          l10n.retryButton,
                                          style: TextStyle(
                                            color: theme.colorScheme.primary, // Theme-aware button text
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  Text(
                                    user?.displayName ?? user?.userName ?? l10n.userNamePlaceholder,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: theme.colorScheme.onBackground, // Theme-aware text color
                                    ),
                                  ),
                                const SizedBox(height: 32),
                                BuildRankCard(
                                  imagePath: AssetsData.cityRank,
                                  title: l10n.cityRankTitle,
                                  rank: state.rank.cityRank,
                                ),
                                const SizedBox(height: 16),
                                BuildRankCard(
                                  imagePath: AssetsData.countryRank,
                                  title: l10n.countryRankTitle,
                                  rank: state.rank.countryRank,
                                ),
                                const SizedBox(height: 16),
                                BuildRankCard(
                                  imagePath: AssetsData.globalRank,
                                  title: l10n.globalRankTitle,
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
                              style: TextStyle(
                                fontSize: 18,
                                color: theme.colorScheme.error, // Theme-aware error color
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () => context.read<HomeCubit>().fetchRanks(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary, // Theme-aware button background
                                foregroundColor: theme.colorScheme.onPrimary, // Theme-aware button text/icon
                              ),
                              child: Text(l10n.retryButton),
                            ),
                          ],
                        )
                      else
                        Center(
                          child: Text(
                            l10n.noRankingsAvailable,
                            style: TextStyle(
                              fontSize: 18,
                              color: theme.colorScheme.onSurface.withOpacity(0.6), // Subtle text color
                            ),
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