import 'dart:math';
import 'package:flutter/material.dart';

// A helper class to hold the data for each slice of the pie.
// The screen will create these objects and pass them to the chart.
class PieSlice {
  final String categoryName;
  final double totalValue;
  final Color color;

  PieSlice({
    required this.categoryName,
    required this.totalValue,
    required this.color,
  });
}

class PieChart extends StatelessWidget {
  final List<PieSlice> slices;
  final double totalIncome;
  final double size;

  const PieChart({
    super.key,
    required this.slices,
    required this.totalIncome,
    this.size = 250.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _PieChartPainter(slices: slices, totalIncome: totalIncome),
      ),
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final List<PieSlice> slices;
  final double totalIncome;

  _PieChartPainter({required this.slices, required this.totalIncome});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    const strokeWidth = 60.0;
    double startAngle = -pi / 2; // Start at the top

    if (totalIncome <= 0) {
      final paint =
          Paint()
            ..color = Colors.grey.shade300
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth;
      canvas.drawCircle(center, radius - strokeWidth / 2, paint);
      return;
    }

    double totalAllocated = 0;

    // Draw a slice for each category
    for (final slice in slices) {
      totalAllocated += slice.totalValue;
      final sweepAngle = (slice.totalValue / totalIncome) * 2 * pi;
      final paint =
          Paint()
            ..color = slice.color
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle;
    }

    // Draw the gray "unallocated" slice for the remaining income
    final unallocatedAmount = totalIncome - totalAllocated;
    if (unallocatedAmount > 0.01) {
      // Use a small epsilon to avoid floating point issues
      final sweepAngle = (unallocatedAmount / totalIncome) * 2 * pi;
      final paint =
          Paint()
            ..color = Colors.grey.shade300
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
