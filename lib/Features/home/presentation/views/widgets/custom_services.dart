import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/app_localizations.dart';
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
    // Get the localization instance
    final l10n = AppLocalizations.of(context)!;

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
              context: context, // Pass context to access l10n
              items: [
                _ServiceItem(
                  color: MyColors.white,
                  asset: AssetsData.calcs,
                  label: l10n.calculationsTile, // Localized
                  onPressed: () => Navigator.pushNamed(context, '/Calculations'),
                ),
                _ServiceItem(
                  color: MyColors.white,
                  asset: AssetsData.statistics,
                  label: l10n.statisticsTile, // Localized
                  onPressed: () => Navigator.pushNamed(context, '/Statistics'),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            _buildServiceRow(
              context: context, // Pass context to access l10n
              items: [
                _ServiceItem(
                  color: MyColors.white,
                  asset: AssetsData.learn,
                  label: l10n.recommendationTile, // Localized
                  onPressed: () => Navigator.pushNamed(context, '/Recommendations'),
                ),
                _ServiceItem(
                  color: MyColors.white,
                  asset: AssetsData.rank,
                  label: l10n.rankTile, // Localized
                  onPressed: () => Navigator.pushNamed(context, '/Rank'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Added context parameter to _buildServiceRow
  Widget _buildServiceRow({required BuildContext context, required List<_ServiceItem> items}) {
    // Get the localization instance inside the method too, if it needs to build localized widgets.
    // In this case, labels are already localized in the _ServiceItem creation.
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
                      decoration: const BoxDecoration( // Kept const where possible
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
                      widget.item.label, // This is already localized
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
