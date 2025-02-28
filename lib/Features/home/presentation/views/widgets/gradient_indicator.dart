import 'package:flutter/material.dart';
import 'dart:math';

class GradientCircularProgressIndicator extends StatelessWidget {
  final double value;
  final double strokeWidth;
  final List<Color> gradientColors; //
  final double size;

  const GradientCircularProgressIndicator({
    Key? key,
    required this.value,
    this.strokeWidth = 12.0,
    this.gradientColors = const [
      Color(0xff58b698),
      Color(0xffaee7d5),
      Color(0xffe58259),
    ],
    this.size = 150.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _GradientCircularPainter(
          value: value,
          strokeWidth: strokeWidth,
          gradientColors: gradientColors,
        ),
      ),
    );
  }
}

class _GradientCircularPainter extends CustomPainter {
  final double value;
  final double strokeWidth;
  final List<Color> gradientColors;

  _GradientCircularPainter({
    required this.value,
    required this.strokeWidth,
    required this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = size.center(Offset.zero);
    final radius = (size.width - strokeWidth) / 2;


    final backgroundPaint = Paint()
      ..color = const Color(0xFFE0E0E0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, backgroundPaint);

    final gradient = SweepGradient(
      colors: gradientColors,
      stops: [0.0, value, 1.0],
      startAngle: -pi / 2,
      endAngle: 2 * pi,
    );

    final gradientPaint = Paint()
      ..shader = gradient.createShader(rect)
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
      gradientPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
