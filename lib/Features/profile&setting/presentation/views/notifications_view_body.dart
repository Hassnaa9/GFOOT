import 'package:flutter/material.dart';
import 'package:graduation_project/Features/profile&setting/presentation/views/widgets/notification_card.dart';
// Import the generated AppLocalizations class
import 'package:graduation_project/app_localizations.dart';


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

  // Change to a non-late variable and initialize in didChangeDependencies
  List<NotificationModel> _notifications = [];
  bool _isNotificationsInitialized = false; // Flag to ensure initialization only once

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize notifications here, where BuildContext is fully available
    if (!_isNotificationsInitialized) {
      final l10n = AppLocalizations.of(context)!;
      _notifications = _buildNotifications(l10n);
      _isNotificationsInitialized = true;
    }
  }

  // Helper method to build localized notifications
  List<NotificationModel> _buildNotifications(AppLocalizations l10n) {
    return [
      NotificationModel(
        title: l10n.notificationLogActivityTitle,
        description: l10n.notificationLogActivityDescription,
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        icon: Icons.directions_car,
      ),
      NotificationModel(
        title: l10n.notificationGreatJobTitle,
        description: l10n.notificationGreatJobDescription,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        icon: Icons.eco,
      ),
      NotificationModel(
        title: l10n.notificationSustainableTipTitle,
        description: l10n.notificationSustainableTipDescription,
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        icon: Icons.lightbulb_outline,
      ),
      NotificationModel(
        title: l10n.notificationHighCarbonAlertTitle,
        description: l10n.notificationHighCarbonAlertDescription,
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        icon: Icons.flight,
      ),
      NotificationModel(
        title: l10n.notificationMilestoneAchievedTitle,
        description: l10n.notificationMilestoneAchievedDescription,
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        icon: Icons.star,
      ),
      NotificationModel(
        title: l10n.notificationEnergySavingTipTitle,
        description: l10n.notificationEnergySavingTipDescription,
        timestamp: DateTime.now().subtract(const Duration(days: 4)),
        icon: Icons.power_off,
      ),
      NotificationModel(
        title: l10n.notificationChallengeAcceptedTitle,
        description: l10n.notificationChallengeAcceptedDescription,
        timestamp: DateTime.now().subtract(const Duration(days: 5)),
        icon: Icons.restaurant_menu,
      ),
      NotificationModel(
        title: l10n.notificationCommunityUpdateTitle,
        description: l10n.notificationCommunityUpdateDescription,
        timestamp: DateTime.now().subtract(const Duration(days: 6)),
        icon: Icons.recycling,
      ),
      NotificationModel(
        title: l10n.notificationWaterConservationTipTitle,
        description: l10n.notificationWaterConservationTipDescription,
        timestamp: DateTime.now().subtract(const Duration(days: 7)),
        icon: Icons.water_drop,
      ),
      NotificationModel(
        title: l10n.notificationMonthlySummaryTitle,
        description: l10n.notificationMonthlySummaryDescription,
        timestamp: DateTime.now().subtract(const Duration(days: 8)),
        icon: Icons.analytics,
      ),
    ];
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
    return Scaffold(
      backgroundColor:  Colors.white, // Light green background
      appBar: AppBar(
        backgroundColor:  Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          l10n.notificationsTitle, // Localized
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: _notifications.isEmpty
            ? Center( // No longer const
                child: Text(
                  l10n.noNotificationsYetMessage, // Localized
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
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
    // Get the localization instance
    final l10n = AppLocalizations.of(context)!;

    if (difference.inDays > 0) {
      // Use plural/singular localization based on the number of days
      if (difference.inDays == 1) {
        return l10n.dayAgo(difference.inDays);
      }
      return l10n.daysAgo(difference.inDays); // Localized
    } else if (difference.inHours > 0) {
      // Use plural/singular localization based on the number of hours
      if (difference.inHours == 1) {
        return l10n.hourAgo(difference.inHours);
      }
      return l10n.hoursAgo(difference.inHours); // Localized
    } else if (difference.inMinutes > 0) {
      // Use plural/singular localization based on the number of minutes
      if (difference.inMinutes == 1) {
        return l10n.minuteAgo(difference.inMinutes);
      }
      return l10n.minutesAgo(difference.inMinutes); // Localized
    } else {
      return l10n.justNow; // Localized
    }
  }
}
