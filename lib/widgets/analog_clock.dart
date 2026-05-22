import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnalogClock extends StatelessWidget {
  final DateTime now;

  const AnalogClock({super.key, required this.now});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = math.min(constraints.maxWidth, constraints.maxHeight);
        return Center(
          child: SizedBox(
            width: size,
            height: size,
            child: CustomPaint(
              painter: _ClockPainter(now, Theme.of(context).colorScheme),
            ),
          ),
        );
      },
    );
  }
}

class _ClockPainter extends CustomPainter {
  final DateTime now;
  final ColorScheme cs;
  _ClockPainter(this.now, this.cs);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    final paint = Paint()..color = cs.surfaceContainerHighest;
    canvas.drawCircle(center, radius, paint);

    final tickPaint = Paint()
      ..color = cs.onSurface.withValues(alpha: 0.8)
      ..strokeWidth = 2;
    for (int i = 0; i < 12; i++) {
      final angle = (i / 12) * 2 * math.pi;
      final p1 =
          center + Offset(math.sin(angle), -math.cos(angle)) * (radius * 0.85);
      final p2 =
          center + Offset(math.sin(angle), -math.cos(angle)) * (radius * 0.95);
      canvas.drawLine(p1, p2, tickPaint);
    }

    final hour = now.hour % 12 + now.minute / 60;
    final minute = now.minute + now.second / 60;
    final second = now.second + now.millisecond / 1000;

    final hourAngle = (hour / 12) * 2 * math.pi;
    final minuteAngle = (minute / 60) * 2 * math.pi;
    final secondAngle = (second / 60) * 2 * math.pi;

    final hourPaint = Paint()
      ..color = cs.onSurface
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    final minutePaint = Paint()
      ..color = cs.onSurface.withValues(alpha: 0.9)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    final secondPaint = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      center,
      center +
          Offset(math.sin(hourAngle), -math.cos(hourAngle)) * (radius * 0.5),
      hourPaint,
    );
    canvas.drawLine(
      center,
      center +
          Offset(math.sin(minuteAngle), -math.cos(minuteAngle)) *
              (radius * 0.7),
      minutePaint,
    );
    canvas.drawLine(
      center,
      center +
          Offset(math.sin(secondAngle), -math.cos(secondAngle)) *
              (radius * 0.8),
      secondPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ClockPainter oldDelegate) =>
      oldDelegate.now.second != now.second;
}
