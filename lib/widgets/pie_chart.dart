import 'dart:math';
import 'package:flutter/material.dart';

// A helper class to hold the data for each slice of the pie.
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

class PieChart extends StatefulWidget {
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
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  int? _selectedIndex;
  // This list will hold the geometric path of each slice for tap detection.
  List<Path> _slicePaths = [];

  // This method calculates which slice was tapped using path hit-testing.
  void _handleTap(TapUpDetails details) {
    if (_slicePaths.isEmpty) return;

    final tapPosition = details.localPosition;
    int? tappedIndex;

    // Check which path, if any, contains the tap position.
    for (int i = 0; i < _slicePaths.length; i++) {
      if (_slicePaths[i].contains(tapPosition)) {
        tappedIndex = i;
        break;
      }
    }

    setState(() {
      // If the tapped index is the same as the currently selected one, deselect it.
      // Otherwise, select the new index.
      if (_selectedIndex == tappedIndex) {
        _selectedIndex = null;
      } else {
        _selectedIndex = tappedIndex;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: GestureDetector(
        onTapUp: _handleTap,
        child: CustomPaint(
          painter: _PieChartPainter(
            slices: widget.slices,
            totalIncome: widget.totalIncome,
            selectedIndex: _selectedIndex,
            // Pass a callback to get the generated paths from the painter.
            onPathsGenerated: (paths) {
              // Use a post-frame callback to avoid calling setState during a build.
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    _slicePaths = paths;
                  });
                }
              });
            },
          ),
        ),
      ),
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final List<PieSlice> slices;
  final double totalIncome;
  final int? selectedIndex;
  final ValueChanged<List<Path>> onPathsGenerated;

  _PieChartPainter({
    required this.slices,
    required this.totalIncome,
    this.selectedIndex,
    required this.onPathsGenerated,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = min(size.width / 2, size.height / 2);
    const strokeWidth = 50.0;
    const startAngle = -pi / 2; // Start at the top

    final List<Path> generatedPaths = [];

    // If there's no income, draw an empty grey ring and stop.
    if (totalIncome <= 0) {
      final paint =
          Paint()
            ..color = Colors.grey.shade300
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth;
      canvas.drawCircle(center, baseRadius - strokeWidth / 2, paint);
      onPathsGenerated([]); // Report that there are no paths
      return;
    }

    double cumulativeAngle = 0.0;
    final scaleFactor = (2 * pi) / totalIncome;

    for (int i = 0; i < slices.length; i++) {
      final slice = slices[i];
      final sweepAngle = slice.totalValue * scaleFactor;
      final revolutions = (cumulativeAngle / (2 * pi)).floor();
      final currentRadius =
          baseRadius - (strokeWidth / 2) - (revolutions * (strokeWidth + 5));

      final paint =
          Paint()
            ..color = slice.color
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth;

      // --- Path Generation for Hit Detection ---
      final path = Path();
      path.addArc(
        Rect.fromCircle(center: center, radius: currentRadius),
        startAngle + cumulativeAngle,
        sweepAngle,
      );
      generatedPaths.add(path);

      // Draw the arc on the canvas
      canvas.drawPath(path, paint);

      // --- Tooltip Drawing Logic ---
      if (i == selectedIndex) {
        final midpointAngle = startAngle + cumulativeAngle + (sweepAngle / 2);
        final tooltipRadius = currentRadius + strokeWidth / 2 + 15;
        final x = center.dx + tooltipRadius * cos(midpointAngle);
        final y = center.dy + tooltipRadius * sin(midpointAngle);

        _drawTooltip(canvas, slice.categoryName, Offset(x, y), size);
      }

      cumulativeAngle += sweepAngle;
    }

    // Report the generated paths back to the widget state.
    onPathsGenerated(generatedPaths);
  }

  void _drawTooltip(
    Canvas canvas,
    String text,
    Offset position,
    Size canvasSize,
  ) {
    final textSpan = TextSpan(
      text: text,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: canvasSize.width * 0.7);

    // --- Smart Positioning Logic ---
    double finalX = position.dx - textPainter.width / 2;
    double finalY = position.dy - textPainter.height / 2;

    if (finalX < 0) finalX = 0;
    if (finalX + textPainter.width > canvasSize.width)
      finalX = canvasSize.width - textPainter.width;
    if (finalY < 0) finalY = 0;
    if (finalY + textPainter.height > canvasSize.height)
      finalY = canvasSize.height - textPainter.height;

    final offset = Offset(finalX, finalY);

    final backgroundRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        offset.dx - 8,
        offset.dy - 4,
        textPainter.width + 16,
        textPainter.height + 8,
      ),
      const Radius.circular(8),
    );
    final backgroundPaint = Paint()..color = Colors.white.withOpacity(0.95);
    final borderPaint =
        Paint()
          ..color = Colors.grey.shade300
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

    canvas.drawRRect(backgroundRect, backgroundPaint);
    canvas.drawRRect(backgroundRect, borderPaint);

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Keep it simple for now, repaint on any change.
  }
}
