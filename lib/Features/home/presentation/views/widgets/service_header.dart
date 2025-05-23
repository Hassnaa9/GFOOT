import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:graduation_project/constants.dart';

class EnhancedServicesHeader extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final VoidCallback? onTap; // Optional callback for tap action

  const EnhancedServicesHeader({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    this.onTap,
  });

  @override
  _EnhancedServicesHeaderState createState() => _EnhancedServicesHeaderState();
}

class _EnhancedServicesHeaderState extends State<EnhancedServicesHeader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Scale animation on tap
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: const Duration(milliseconds: 600),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: GestureDetector(
            onTapDown: (_) {
              setState(() => _isTapped = true);
              _controller.forward();
            },
            onTapUp: (_) {
              setState(() => _isTapped = false);
              _controller.reverse();
              if (widget.onTap != null) widget.onTap!();
            },
            onTapCancel: () {
              setState(() => _isTapped = false);
              _controller.reverse();
            },
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _isTapped ? 0.95 : 1.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.screenWidth * 0.002,
                      vertical: widget.screenHeight * 0.005,
                    ),
                    width: widget.screenWidth * 0.7,
                    height: widget.screenHeight * 0.05,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          MyColors.serviceCard.withOpacity(0.9),
                          MyColors.kPrimaryColor.withOpacity(0.6),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.kPrimaryColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Explore our services",
                        style: TextStyle(
                          fontSize: widget.screenWidth * 0.04, // Responsive font size
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // White text for contrast
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 1,
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}