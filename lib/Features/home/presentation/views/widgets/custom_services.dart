import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/Features/home/statistics.dart';
import 'package:graduation_project/constants.dart';

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
    return AnimationLimiter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 600),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: widget,
            ),
          ),
          children: [
            // First Row of Services
            _buildServiceRow(
              items: [
                _ServiceItem(
                  color: MyColors.serviceCard,
                  asset: AssetsData.calcs,
                  label: "Calculations",
                  onPressed: () {
                    Navigator.pushNamed(context, '/Calculations');
                  },
                ),
                _ServiceItem(
                  color: MyColors.kPrimaryColor,
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
                  color: MyColors.serviceCard,
                  asset: AssetsData.learn,
                  label: "Recommendation",
                  onPressed: () {
                    Navigator.pushNamed(context, '/Recommendations');
                  },
                ),
                _ServiceItem(
                  color: MyColors.kPrimaryColor,
                  asset: AssetsData.rank,
                  label: "Rank",
                  onPressed: () {
                    Navigator.pushNamed(context, '/Rank');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Builds a row of service cards
  Widget _buildServiceRow({required List<_ServiceItem> items}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 600),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: SizedBox(
                width: screenWidth * 0.3, // Ensures equal card sizes
                child: _AnimatedServiceCard(item: item, screenHeight: screenHeight),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// Animated service card with tap and hover effects
class _AnimatedServiceCard extends StatefulWidget {
  final _ServiceItem item;
  final double screenHeight;

  const _AnimatedServiceCard({
    required this.item,
    required this.screenHeight,
  });

  @override
  _AnimatedServiceCardState createState() => _AnimatedServiceCardState();
}

class _AnimatedServiceCardState extends State<_AnimatedServiceCard> {
  bool _isTapped = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isTapped = true),
        onTapUp: (_) {
          setState(() => _isTapped = false);
          widget.item.onPressed();
        },
        onTapCancel: () => setState(() => _isTapped = false),
        child: AnimatedScale(
          scale: _isTapped ? 0.95 : _isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: widget.item.color,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon container
                Container(
                  width: double.infinity,
                  height: widget.screenHeight * 0.16,
                  decoration: const BoxDecoration(
                    color: MyColors.serviceCard,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Center(
                    child: Image.asset(
                      widget.item.asset,
                      fit: BoxFit.contain,
                      height: widget.screenHeight * 0.08,
                    ),
                  ),
                ),
                // Text container
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
                  ),
                  child: Text(
                    widget.item.label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: MyColors.serviceCard,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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