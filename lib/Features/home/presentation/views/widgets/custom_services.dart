import 'package:flutter/material.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/Features/home/statistics.dart';

class CustomServices extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const CustomServices({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // First Row of Services
        _buildServiceRow(
          items: [
            _ServiceItem(
              color: const Color(0xffD4E0EB),
              asset: AssetsData.calcs,
              label: "Calculations",
              onPressed: () {
                Navigator.pushNamed(context, '/Calculations');
              },
            ),
            _ServiceItem(
              color: const Color(0xFFD4E0EB), // Updated Color
              asset: AssetsData.statistics,
              label: "Statistics",
              onPressed: () {
                 Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Statistics()),
        );
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Second Row of Services
        _buildServiceRow(
          items: [
            _ServiceItem(
              color: const Color(0xFFD4E0EB), 
              asset: AssetsData.learn,
              label: "Recommendation",
              onPressed: () {
                Navigator.pushNamed(context, '/Recommendations');
              },
              
            ),
            _ServiceItem(
              color: const Color(0xFFD4E0EB), 
              asset: AssetsData.rank,
              label: "Rank",
              onPressed: () {
                Navigator.pushNamed(context, '/Rank');
              },
            ),
          ],
        ),
      ],
    );
  }

  // Builds a row of service cards
  Widget _buildServiceRow({required List<_ServiceItem> items}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: items.map((item) {
        return SizedBox(
          width: screenWidth * 0.3, // Ensures equal card sizes
          child: _buildServiceCard(item),
        );
      }).toList(),
    );
  }

  // Builds an individual service card
  Widget _buildServiceCard(_ServiceItem item) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: item.color, // Updated Background Color
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // White container for the icon wrapped with InkWell for click functionality
          InkWell(
            onTap: item.onPressed, // Handle the tap event
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.2, // Adaptive size
              decoration: const BoxDecoration(
                color: Color(0xffD4E0EB),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Center(
                child: Image.asset(
                  item.asset,
                  fit: BoxFit.contain,
                  height: screenHeight * 0.08, // Icon size
                ),
              ),
            ),
          ),
          // Text below the container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white, // Background color for the text
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Text(
              item.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Model for a service item
class _ServiceItem {
  final Color color;
  final String asset;
  final String label;
  final VoidCallback onPressed;

  _ServiceItem({
    required this.color,
    required this.asset,
    required this.label,
    required this.onPressed,
  });
}
