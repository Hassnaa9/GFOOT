import 'package:flutter/material.dart';
import 'package:graduation_project/Features/profile&setting/presentation/views/profile_view_body.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  final String route = '/Profile';

  @override
  Widget build(BuildContext context) {
    return ProfileViewBody();
  }
}