import 'package:flutter/material.dart';
import 'package:graduation_project/Features/profile/presentation/views/notifications_view_body.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});
  final String route = "/Notifications";

  @override
  Widget build(BuildContext context) {
    return NotificationsViewBody();
  }
}