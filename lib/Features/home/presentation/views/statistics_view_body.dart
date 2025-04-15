// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:graduation_project/Features/home/presentation/view_models/home_cubit.dart';
// import 'package:graduation_project/Features/home/presentation/view_models/home_cubit_state.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';

// class StatisticsViewBody extends StatefulWidget {
//   const StatisticsViewBody({super.key});

//   @override
//   State<StatisticsViewBody> createState() => _DailyReportScreenState();
// }

// class _DailyReportScreenState extends State<StatisticsViewBody> {
//   int _selectedTabIndex = 0;
//   int _selectedNavIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     context.read<HomeCubit>().fetchStatistics('Daily');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text('Daily report'),
//         backgroundColor: Colors.grey[100],
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: BlocBuilder<HomeCubit, HomeState>(
//         builder: (context, state) {
//           if (state is HomeLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is HomeStatisticsError) {
//             return Center(child: Text(state.message));
//           } else if (state is HomeStatisticsLoaded) {
//             final data = state.statistics;
//             final date = DateTime.parse(data['date']);
//             final progress = data['progress'] as double;
//             final statistics = (data['statistics'] as Map<String, dynamic>)
//                 .values
//                 .toList()
//                 .cast<double>();
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: CircularPercentIndicator(
//                       radius: 80.0,
//                       lineWidth: 12.0,
//                       percent: progress,
//                       center: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             date.day.toString(),
//                             style: const TextStyle(
//                               fontSize: 32,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           Text(
//                             _getMonthName(date.month),
//                             style: const TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                       progressColor: Colors.green,
//                       backgroundColor: Colors.blue,
//                       circularStrokeCap: CircularStrokeCap.round,
//                       linearGradient: const LinearGradient(
//                         colors: [Colors.green, Colors.orange, Colors.blue],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildTabButton('Daily', 0),
//                       _buildTabButton('Weekly', 1),
//                       _buildTabButton('Monthly', 2),
//                       _buildTabButton('Yearly', 3),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     'Overall statistics',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.all(16.0),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: BarChart(
//                         BarChartData(
//                           alignment: BarChartAlignment.spaceAround,
//                           maxY: statistics.reduce((a, b) => a > b ? a : b) + 2,
//                           barTouchData: BarTouchData(enabled: false),
//                           titlesData: FlTitlesData(
//                             show: true,
//                             bottomTitles: AxisTitles(
//                               sideTitles: SideTitles(
//                                 showTitles: true,
//                                 getTitlesWidget: (value, meta) {
//                                   const months = ['Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'];
//                                   return Text(
//                                     months[value.toInt()],
//                                     style: const TextStyle(color: Colors.grey, fontSize: 12),
//                                   );
//                                 },
//                               ),
//                             ),
//                             leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                             topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                             rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                           ),
//                           borderData: FlBorderData(show: false),
//                           barGroups: List.generate(statistics.length, (index) {
//                             return BarChartGroupData(
//                               x: index,
//                               barRods: [
//                                 BarChartRodData(toY: statistics[index], color: Colors.green),
//                               ],
//                             );
//                           }),
//                           gridData: FlGridData(show: false),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             );
//           }
//           return const SizedBox();
//         },
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedNavIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedNavIndex = index;
//           });
//           // Add navigation logic
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Learn'),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         showUnselectedLabels: true,
//       ),
//     );
//   }

//   Widget _buildTabButton(String title, int index) {
//     bool isSelected = _selectedTabIndex == index;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedTabIndex = index;
//         });
//         context.read<HomeCubit>().fetchStatistics(title);
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.green : Colors.grey[200],
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(
//           title,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Colors.black,
//             fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),
//       ),
//     );
//   }

//   String _getMonthName(int month) {
//     const months = [
//       'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//     ];
//     return months[month - 1];
//   }
// }
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StatisticsViewBody extends StatefulWidget {
  const StatisticsViewBody({super.key});

  @override
  State<StatisticsViewBody> createState() => _StatisticsViewBodyState();
}

class _StatisticsViewBodyState extends State<StatisticsViewBody> {
  int _selectedTabIndex = 0;
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Hardcoded data for UI testing
    const double progress = 0.75;
    final List<double> statistics = [4.5, 6.0, 5.2, 7.1, 3.8, 5.5];
    final DateTime date = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.white, // Light background
      appBar: AppBar(
        title: const Text(
          'Daily report',
          style: TextStyle(color: Colors.black), // Dark text for light mode
        ),
        backgroundColor: Colors.white, // Light AppBar background
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Center(
              child: CircularPercentIndicator(
                radius: 80.0,
                lineWidth: 12.0,
                percent: progress,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      date.day.toString(),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Dark text for light mode
                      ),
                    ),
                    Text(
                      _getMonthName(date.month),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey, // Keep grey for secondary text
                      ),
                    ),
                  ],
                ),
                progressColor: Colors.green,
                backgroundColor: Colors.grey[300]!, // Lighter background for the ring
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabButton('Daily', 0),
                _buildTabButton('Weekly', 1),
                _buildTabButton('Monthly', 2),
                _buildTabButton('Yearly', 3),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Overall statistics',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Dark text for light mode
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Lighter container background
                  borderRadius: BorderRadius.circular(16),
                ),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: statistics.reduce((a, b) => a > b ? a : b) + 2,
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const months = ['Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'];
                            return Text(
                              months[value.toInt()],
                              style: const TextStyle(
                                color: Colors.grey, // Keep grey for axis labels
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: List.generate(statistics.length, (index) {
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: statistics[index],
                            color: Colors.green, // Keep green for bars
                          ),
                        ],
                      );
                    }),
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Light background for nav bar
        currentIndex: _selectedNavIndex,
        onTap: (index) {
          setState(() {
            _selectedNavIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Learn'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.grey[300], // Lighter unselected color
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black, // Dark text for unselected
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}