import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/models/recommendations_model.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit_state.dart';
import 'package:graduation_project/Features/profile&setting/presentation/views/widgets/notification_card.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFFE5F5F0), // Light green background
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5F5F0),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Your Eco Recommendations",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeRecommendationsLoaded) {
              final recommendations = state.recommendations;
              if (recommendations.isEmpty) {
                return const Center(
                  child: Text(
                    "No Recommendations yet!",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
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
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        context.read<HomeCubit>().fetchRecommendations();
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: Text(
                "No Recommendations yet!",
                style: TextStyle(fontSize: 18, color: Colors.grey),
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

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago";
    } else {
      return "Just now";
    }
  }
}