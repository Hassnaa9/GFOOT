import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:graduation_project/Core/utils/assets.dart';
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
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 600),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(child: widget),
          ),
          children: [
            _buildServiceRow(
              items: [
                _ServiceItem(
                  color: MyColors.white,
                  asset: AssetsData.calcs,
                  label: "Calculations",
                  onPressed: () => Navigator.pushNamed(context, '/Calculations'),
                ),
                _ServiceItem(
                  color: MyColors.white,
                  asset: AssetsData.statistics,
                  label: "Statistics",
                  onPressed: () => Navigator.pushNamed(context, '/Statistics'),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            _buildServiceRow(
              items: [
                _ServiceItem(
                  color: MyColors.white,
                  asset: AssetsData.learn,
                  label: "Recommendation",
                  onPressed: () => Navigator.pushNamed(context, '/Recommendations'),
                ),
                _ServiceItem(
                  color: MyColors.white,
                  asset: AssetsData.rank,
                  label: "Rank",
                  onPressed: () => Navigator.pushNamed(context, '/Rank'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
                width: screenWidth * 0.37,
                height: screenHeight * 0.21,
                child: _AnimatedServiceCard(item: item, screenWidth: screenWidth, screenHeight: screenHeight),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _AnimatedServiceCard extends StatefulWidget {
  final _ServiceItem item;
  final double screenWidth;
  final double screenHeight;
  const _AnimatedServiceCard({required this.item, required this.screenWidth, required this.screenHeight});
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
            elevation: 2,
            color: widget.item.color,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                     padding: const EdgeInsets.only(top: 12.0),
                    child: Container(
                      width: widget.screenWidth * 0.28,
                      decoration: BoxDecoration(
                        color: (Color(0xFFC1E3C6)
                    ),                    ),
                      child: Center(
                        child: Image.asset(
                          widget.item.asset,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: widget.screenWidth * 0.28,
                    decoration: const BoxDecoration(
                      color: MyColors.white,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.item.label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: MyColors.black,
                      ),
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
