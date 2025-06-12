import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/models/statistics_model.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit_state.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/custom_carbon_result.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/gradient_indicator.dart';
import 'package:graduation_project/app_localizations.dart';
import 'package:graduation_project/constants.dart';
import 'package:intl/intl.dart';
import 'dart:math';


class StatisticsViewBody extends StatefulWidget {
  const StatisticsViewBody({super.key});

  @override
  State<StatisticsViewBody> createState() => _StatisticsViewBodyState();
}

class _StatisticsViewBodyState extends State<StatisticsViewBody> {
  int _selectedTabIndex = 0;
  int _touchedGroupIndex = -1;
  String _currentStatsType = 'Daily';

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchStatistics(_currentStatsType);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // Get the localization instance
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text( // No longer const
          l10n.carbonEmissionReportTitle, // Localized
          style: const TextStyle(color: MyColors.kPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator(color: MyColors.kPrimaryColor));
          } else if (state is HomeStatisticsError) {
            return Center(child: Text(state.message));
          } else if (state is HomeStatisticsLoaded) {
            final List<EmissionEntry> stats = state.statistics;
            final statistics = stats.map((e) => e.carbonEmission).toList();
            double sum = statistics.fold(0.0, (a, b) => a + b);

            // Determine the target emission limit based on selected tab
            double limit;
            switch (_currentStatsType) {
              case 'Monthly':
                limit = 2500 * 30;
                break;
              case 'Yearly':
                limit = 2500 * 365;
                break;
              case 'Daily':
              default:
                limit = 2500;
            }

            final progress = (sum / limit).clamp(0.0, 1.0);

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth * .35,
                            height: screenWidth * .30,
                            child: GradientCircularProgressIndicator(
                              value: progress,
                              size: screenWidth * .8,
                              strokeWidth: 15.0,
                            ),
                          ),
                          CustomCarbonResult(carbonFootprint: sum), // You may add `progress` too
                        ],
                      ),
                      SizedBox(height: screenHeight * .03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTabButton(l10n.dailyTab, 0), // Localized
                          _buildTabButton(l10n.monthlyTab, 1), // Localized
                          _buildTabButton(l10n.yearlyTab, 2), // Localized
                        ],
                      ),
                      const SizedBox(height: 18),
                      Align( // No longer const
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.emissionTrendsTitle, // Localized
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: MyColors.kPrimaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: statistics.isEmpty
                            ? Center(child: Text(l10n.noDataAvailable)) // Localized
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: max(400, statistics.length * 60),
                                  height: 300,
                                  child: BarChart(
                                    BarChartData(
                                      alignment: BarChartAlignment.spaceAround,
                                      maxY: statistics.reduce(max) + 500,
                                      barTouchData: BarTouchData(
                                        enabled: true,
                                        touchTooltipData: BarTouchTooltipData(
                                          getTooltipColor: (_) => const Color(0xFFEAEAEA),
                                          tooltipPadding: const EdgeInsets.all(8),
                                          tooltipRoundedRadius: 8,
                                          getTooltipItem: (group, _, rod, __) {
                                            return BarTooltipItem(
                                              '${rod.toY.toStringAsFixed(1)} ${l10n.kilogramAbbreviation}', // Localized
                                              const TextStyle(color: Colors.black87),
                                            );
                                          },
                                        ),
                                        touchCallback: (event, response) {
                                          setState(() {
                                            _touchedGroupIndex = response?.spot?.touchedBarGroupIndex ?? -1;
                                          });
                                        },
                                      ),
                                      titlesData: FlTitlesData(
                                        show: true,
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: (value, _) {
                                              final index = value.toInt();
                                              if (index >= statistics.length) return const SizedBox();
                                              final barDate = stats[index].date;
                                              // Format date based on selected tab (daily/monthly/yearly)
                                              String formatString;
                                              if (_currentStatsType == 'Daily') {
                                                formatString = 'MM/dd';
                                              } else if (_currentStatsType == 'Monthly') {
                                                formatString = 'MMM yy';
                                              } else { // Yearly
                                                formatString = 'yyyy';
                                              }
                                              return Padding(
                                                padding: const EdgeInsets.only(top: 8.0),
                                                child: Text(
                                                  DateFormat(formatString).format(barDate),
                                                  style: const TextStyle(color: Colors.black54, fontSize: 11),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        leftTitles: AxisTitles(
                                          sideTitles: SideTitles(showTitles: false),
                                        ),
                                        topTitles: AxisTitles(
                                          sideTitles: SideTitles(showTitles: false),
                                        ),
                                        rightTitles: AxisTitles(
                                          sideTitles: SideTitles(showTitles: false),
                                        ),
                                      ),
                                      borderData: FlBorderData(show: false),
                                      barGroups: List.generate(statistics.length, (index) {
                                        return BarChartGroupData(
                                          x: index,
                                          barsSpace: 6,
                                          barRods: [
                                            BarChartRodData(
                                              toY: statistics[index],
                                              width: 22,
                                              color: _touchedGroupIndex == index
                                                  ? const Color.fromARGB(255, 214, 205, 205)
                                                  : MyColors.kPrimaryColor,
                                              borderRadius: BorderRadius.circular(4),
                                            )
                                          ],
                                        );
                                      }),
                                      gridData: FlGridData(show: false),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
          // _currentStatsType is already localized through the title parameter
          // we pass to it, we just need to map it back to the English values for API calls
          _currentStatsType = [AppLocalizations.of(context)!.dailyTab, AppLocalizations.of(context)!.monthlyTab, AppLocalizations.of(context)!.yearlyTab][index];

          // Use the English values for API calls as expected by the backend
          if (_currentStatsType == AppLocalizations.of(context)!.dailyTab) {
            _currentStatsType = 'Daily';
          } else if (_currentStatsType == AppLocalizations.of(context)!.monthlyTab) {
            _currentStatsType = 'Monthly';
          } else if (_currentStatsType == AppLocalizations.of(context)!.yearlyTab) {
            _currentStatsType = 'Yearly';
          }
        });
        context.read<HomeCubit>().fetchStatistics(_currentStatsType);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? MyColors.kPrimaryColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title, // Already localized when passed to this method
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
