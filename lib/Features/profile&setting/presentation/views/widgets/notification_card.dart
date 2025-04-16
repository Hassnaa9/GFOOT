import 'package:flutter/material.dart';

class NotificationModel {
  final String title;
  final String description;
  final DateTime timestamp;
  final IconData? icon;

  NotificationModel({
    required this.title,
    required this.description,
    required this.timestamp,
    this.icon,
  });
}

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({Key? key, required this.notification}) : super(key: key);

  String _formatTimestamp(DateTime timestamp) {
    // Format the timestamp as needed
    return '${timestamp.hour}:${timestamp.minute}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            // Icon
            if (notification.icon != null)
              Icon(
                notification.icon,
                color: Colors.green,
                size: 30,
              )
            else
              const SizedBox(width: 30), // Placeholder if no icon
            const SizedBox(width: 10),
            // Notification details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    notification.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _formatTimestamp(notification.timestamp),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
