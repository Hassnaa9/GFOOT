import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/models/recommendations_model.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit_state.dart';
import 'package:graduation_project/Features/profile&setting/presentation/views/widgets/notification_card.dart';
import 'package:graduation_project/app_localizations.dart';

class RecommendationsViewBody extends StatefulWidget {
  const RecommendationsViewBody({super.key});

  @override
  State<RecommendationsViewBody> createState() => _RecommendationsViewBodyState();
}

class _RecommendationsViewBodyState extends State<RecommendationsViewBody>
    with SingleTickerProviderStateMixin {
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

    // Fetch recommendations when the widget is initialized
    context.read<HomeCubit>().fetchRecommendations();
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
        backgroundColor: theme.appBarTheme.backgroundColor, // Theme-aware AppBar background
        elevation: theme.appBarTheme.elevation ?? 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.appBarTheme.iconTheme?.color ?? theme.colorScheme.onBackground, // Theme-aware icon color
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.yourEcoRecommendationsTitle,
          style: theme.appBarTheme.titleTextStyle ?? TextStyle(
            color: theme.colorScheme.onBackground, // Fallback to onBackground
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: theme.colorScheme.primary, // Theme-aware indicator color
                ),
              );
            } else if (state is HomeRecommendationsLoaded) {
              final recommendations = state.recommendations;
              if (recommendations.isEmpty) {
                return Center(
                  child: Text(
                    l10n.noRecommendationsYetMessage,
                    style: TextStyle(
                      fontSize: 18,
                      color: theme.colorScheme.onSurface.withOpacity(0.6), // Subtle text color
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: recommendations.length,
                itemBuilder: (context, index) {
                  final recommendation = recommendations[index];
                  // Convert Recommendation to NotificationModel for NotificationCard
                  final notification = NotificationModel(
                    title: recommendation.title,
                    description: recommendation.description,
                    timestamp: recommendation.timestamp,
                    icon: _getIconForRecommendation(recommendation),
                  );
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: NotificationCard(notification: notification),
                    ),
                  );
                },
              );
            } else if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.errorMessage,
                      style: TextStyle(
                        fontSize: 18,
                        color: theme.colorScheme.error, // Theme-aware error color
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => context.read<HomeCubit>().fetchRecommendations(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary, // Theme-aware button background
                        foregroundColor: theme.colorScheme.onPrimary, // Theme-aware button text/icon
                      ),
                      child: Text(l10n.retryButton),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Text(
                l10n.noRecommendationsYetMessage,
                style: TextStyle(
                  fontSize: 18,
                  color: theme.colorScheme.onSurface.withOpacity(0.6), // Subtle text color
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Helper method to map recommendation categories to icons
  IconData _getIconForRecommendation(Recommendation recommendation) {
    switch (recommendation.category.toLowerCase()) {
      case 'food':
        return Icons.restaurant_menu;
      case 'clothing':
        return Icons.checkroom;
      case 'general':
        return Icons.info;
      default:
        return Icons.info;
    }
  }
}