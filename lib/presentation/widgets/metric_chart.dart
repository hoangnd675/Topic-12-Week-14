import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/dashboard_view_model.dart';

class MetricChart extends StatelessWidget {
  const MetricChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Biến động hiệu năng', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('24 mẫu dữ liệu gần nhất', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 22),
            SizedBox(
              height: 190,
              width: double.infinity,
              child: Selector<DashboardViewModel, List<double>>(
                selector: (_, vm) => vm.history.map((e) => e.cpu).toList(),
                builder: (context, values, _) => CustomPaint(
                  painter: _LineChartPainter(
                    values: values,
                    lineColor: Theme.of(context).colorScheme.primary,
                    gridColor: Theme.of(context).dividerColor.withValues(alpha: 0.35),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.circle, size: 9, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 7),
                const Text('CPU usage'),
                const Spacer(),
                Selector<DashboardViewModel, int>(
                  selector: (_, vm) => vm.updateCount,
                  builder: (_, count, __) => Text('Cập nhật: $count'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  const _LineChartPainter({
    required this.values,
    required this.lineColor,
    required this.gridColor,
  });

  final List<double> values;
  final Color lineColor;
  final Color gridColor;

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;
    for (var i = 0; i < 4; i++) {
      final y = size.height * i / 3;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    if (values.length < 2) return;

    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    for (var i = 0; i < values.length; i++) {
      final x = size.width * i / (values.length - 1);
      final y = size.height - (values[i].clamp(0, 100) / 100 * size.height);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) =>
      oldDelegate.values != values ||
      oldDelegate.lineColor != lineColor ||
      oldDelegate.gridColor != gridColor;
}
