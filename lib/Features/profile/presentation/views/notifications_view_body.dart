import 'package:flutter/material.dart';
import 'package:graduation_project/Features/profile/presentation/views/widgets/notification_card.dart';


class NotificationsViewBody extends StatefulWidget {
  const NotificationsViewBody({super.key});

  @override
  State<NotificationsViewBody> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationsViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Sample list of notifications (replace with real data from backend or local storage)
  final List<NotificationModel> _notifications = [
  NotificationModel(
    title: "Log Your Daily Activity",
    description: "Don't forget to log your travel and meals to track your carbon footprint!",
    timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    icon: Icons.directions_car,
  ),
  NotificationModel(
    title: "Great Job!",
    description: "You've reduced your carbon footprint by 5% this week. Keep it up!",
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
    icon: Icons.eco,
  ),
  NotificationModel(
    title: "Sustainable Tip",
    description: "Try walking or biking instead of driving to reduce emissions.",
    timestamp: DateTime.now().subtract(const Duration(days: 2)),
    icon: Icons.lightbulb_outline,
  ),
  NotificationModel(
    title: "High Carbon Alert!",
    description: "Your recent flight has significantly increased your carbon footprint. Consider offsetting with a sustainable action.",
    timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    icon: Icons.flight,
  ),
  NotificationModel(
    title: "Milestone Achieved!",
    description: "Congratulations! You've offset 1 ton of CO2 through your sustainable choices this month!",
    timestamp: DateTime.now().subtract(const Duration(days: 3)),
    icon: Icons.star,
  ),
  NotificationModel(
    title: "Energy Saving Tip",
    description: "Turn off lights and unplug devices when not in use to lower your energy consumption.",
    timestamp: DateTime.now().subtract(const Duration(days: 4)),
    icon: Icons.power_off,
  ),
  NotificationModel(
    title: "Challenge Accepted!",
    description: "You've joined the 'Meatless Monday' challenge. Log your plant-based meals to earn points!",
    timestamp: DateTime.now().subtract(const Duration(days: 5)),
    icon: Icons.restaurant_menu,
  ),
  NotificationModel(
    title: "Community Update",
    description: "Your city just launched a new recycling program. Check it out to reduce waste!",
    timestamp: DateTime.now().subtract(const Duration(days: 6)),
    icon: Icons.recycling,
  ),
  NotificationModel(
    title: "Water Conservation Tip",
    description: "Shorten your showers to save water and reduce your environmental impact.",
    timestamp: DateTime.now().subtract(const Duration(days: 7)),
    icon: Icons.water_drop,
  ),
  NotificationModel(
    title: "Monthly Summary",
    description: "Your carbon footprint for this month is 1.2 tons. Aim for 1 ton next month with small changes!",
    timestamp: DateTime.now().subtract(const Duration(days: 8)),
    icon: Icons.analytics,
  ),
];

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
          "Notifications",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: _notifications.isEmpty
            ? const Center(
                child: Text(
                  "No notifications yet!",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  final notification = _notifications[index];
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: NotificationCard(notification: notification,),
                    ),
                  );
                },
              ),
      ),
    );
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