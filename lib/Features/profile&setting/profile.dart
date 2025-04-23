import 'package:flutter/material.dart';
import 'package:graduation_project/Features/profile&setting/presentation/views/profile_view_body.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String route = '/Profile';

  @override
  Widget build(BuildContext context) {
    return ProfileViewBody();
  }
}