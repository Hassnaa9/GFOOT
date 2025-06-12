import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/models/statistics_model.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit_state.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/custom_carbon_result.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/gradient_indicator.dart';
import 'package:graduation_project/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!; // Localization instance
    final theme = Theme.of(context); // Theme instance for theme-aware colors

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // Theme-aware background
      appBar: AppBar(
        title: Text(
          l10n.carbonEmissionReportTitle,
          style: theme.appBarTheme.titleTextStyle ?? TextStyle(
            color: theme.colorScheme.onBackground, // Fallback to onBackground
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor, // Theme-aware AppBar background
        elevation: theme.appBarTheme.elevation ?? 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.appBarTheme.iconTheme?.color ?? theme.colorScheme.onBackground, // Theme-aware icon color
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white, // Theme-aware indicator color
              ),
            );
          } else if (state is HomeStatisticsError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  color: theme.colorScheme.error, // Theme-aware error color
                ),
              ),
            );
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
                          CustomCarbonResult(carbonFootprint: sum),
                        ],
                      ),
                      SizedBox(height: screenHeight * .03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTabButton(l10n.dailyTab, 0, theme),
                          _buildTabButton(l10n.monthlyTab, 1, theme),
                          _buildTabButton(l10n.yearlyTab, 2, theme),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.emissionTrendsTitle,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary, // Theme-aware primary color
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface.withOpacity(0.1), // Theme-aware subtle background
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: statistics.isEmpty
                            ? Center(
                                child: Text(
                                  l10n.noDataAvailable,
                                  style: TextStyle(
                                    color: theme.colorScheme.onSurface.withOpacity(0.6), // Subtle text color
                                  ),
                                ),
                              )
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
                                          getTooltipColor: (_) => theme.colorScheme.surface, // Theme-aware tooltip background
                                          tooltipPadding: const EdgeInsets.all(8),
                                          tooltipRoundedRadius: 8,
                                          getTooltipItem: (group, _, rod, __) {
                                            return BarTooltipItem(
                                              '${rod.toY.toStringAsFixed(1)} ${l10n.kilogramAbbreviation}',
                                              TextStyle(
                                                color: theme.colorScheme.onSurface, // Theme-aware tooltip text
                                              ),
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
                                              String formatString;
                                              if (_currentStatsType == 'Daily') {
                                                formatString = 'MM/dd';
                                              } else if (_currentStatsType == 'Monthly') {
                                                formatString = 'MMM yy';
                                              } else {
                                                formatString = 'yyyy';
                                              }
                                              return Padding(
                                                padding: const EdgeInsets.only(top: 8.0),
                                                child: Text(
                                                  DateFormat(formatString).format(barDate),
                                                  style: TextStyle(
                                                    color: theme.colorScheme.onSurface.withOpacity(0.7), // Theme-aware label color
                                                    fontSize: 11,
                                                  ),
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
                                                  ? theme.colorScheme.secondary // Theme-aware touched bar color
                                                  : theme.colorScheme.primary, // Theme-aware bar color
                                              borderRadius: BorderRadius.circular(4),
                                            ),
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

  Widget _buildTabButton(String title, int index, dynamic theme) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
          _currentStatsType = [AppLocalizations.of(context)!.dailyTab, AppLocalizations.of(context)!.monthlyTab, AppLocalizations.of(context)!.yearlyTab][index];
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
          color: isSelected ? theme.colorScheme.primary : theme.colorScheme.surface, // Theme-aware button background
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface, // Theme-aware text color
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}