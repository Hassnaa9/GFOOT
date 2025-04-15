import 'package:flutter/material.dart';
import 'package:graduation_project/Features/home/presentation/views/statistics_view_body.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});
    final String route = '/Statistics';


  @override
  Widget build(BuildContext context) {
    return StatisticsViewBody();
  }
}