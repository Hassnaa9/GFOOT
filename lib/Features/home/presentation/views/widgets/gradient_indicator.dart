import 'package:flutter/material.dart';
import 'dart:math';

class GradientCircularProgressIndicator extends StatefulWidget {
  final double value;
  final double strokeWidth;
  final List<Color> gradientColors;
  final double size;

  const GradientCircularProgressIndicator({
    Key? key,
    required this.value,
    this.gradientColors = const [
      Color.fromARGB(255, 8, 243, 114),
      Color.fromARGB(255, 5, 141, 98),
      Color(0xffe58259),
    ], required this.size, required this.strokeWidth,
  }) : super(key: key);

  @override
  _GradientCircularProgressIndicatorState createState() => _GradientCircularProgressIndicatorState();
}

class _GradientCircularProgressIndicatorState extends State<GradientCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _progressAnimation;
  double _previousValue = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Rotation duration
    )..repeat(); // Continuous rotation

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    // Initialize progress animation with current value
    _progressAnimation = Tween<double>(begin: widget.value, end: widget.value).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant GradientCircularProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _previousValue = oldWidget.value;
      _controller.reset();
      _progressAnimation = Tween<double>(begin: _previousValue, end: widget.value).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
        ),
      );
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _GradientCircularPainter(
              value: _progressAnimation.value,
              strokeWidth: widget.strokeWidth,
              gradientColors: widget.gradientColors,
              rotation: _rotationAnimation.value,
            ),
          );
        },
      ),
    );
  }
}

class _GradientCircularPainter extends CustomPainter {
  final double value;
  final double strokeWidth;
  final List<Color> gradientColors;
  final double rotation;

  _GradientCircularPainter({
    required this.value,
    required this.strokeWidth,
    required this.gradientColors,
    required this.rotation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = size.center(Offset.zero);
    final radius = (size.width - strokeWidth) / 2;

    // Background gradient (smooth gradient circle)
    final backgroundGradient = SweepGradient(
      colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
      stops: const [0.0, 0.5, 1.0],
      startAngle: -pi / 2,
      endAngle: 2 * pi,
      transform: GradientRotation(rotation), // Rotate background
    );

    final backgroundPaint = Paint()
      ..shader = backgroundGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress gradient
    final progressGradient = SweepGradient(
      colors: gradientColors,
      stops: [0.0, value, 1.0],
      startAngle: -pi / 2,
      endAngle: 2 * pi,
      transform: GradientRotation(rotation), // Rotate progress arc
    );

    final progressPaint = Paint()
      ..shader = progressGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const startAngle = -pi / 2;
    final sweepAngle = 2 * pi * value;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _GradientCircularPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.rotation != rotation ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gradientColors != gradientColors;
  }
}