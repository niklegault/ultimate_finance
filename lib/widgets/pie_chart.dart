import 'package:flutter/material.dart';

class PieChart extends StatelessWidget {
  final List<double> values;
  final List<Color> colors;
  final double size;
  final double strokeWidth;

  const PieChart({
    Key? key,
    required this.values,
    required this.colors,
    this.size = 200.0,
    this.strokeWidth = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _PieChartPainter(
          values: values,
          colors: colors,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final List<double> values;
  final List<Color> colors;
  final double strokeWidth;

  _PieChartPainter({
    required this.values,
    required this.colors,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double total = values.fold(0, (sum, val) => sum + val);
    double startAngle = -90.0;
    final rect = Offset.zero & size;
    final radius = size.width / 2;

    for (int i = 0; i < values.length; i++) {
      final sweepAngle = (values[i] / total) * 360;
      final paint =
          Paint()
            ..color = colors[i % colors.length]
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth
            ..strokeCap = StrokeCap.butt;

      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(radius, radius),
          radius: radius - strokeWidth / 2,
        ),
        radians(startAngle),
        radians(sweepAngle),
        false,
        paint,
      );
      startAngle += sweepAngle;
    }
  }

  double radians(double degrees) => degrees * 3.1415926535897932 / 180;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
