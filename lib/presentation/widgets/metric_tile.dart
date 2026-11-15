import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/dashboard_view_model.dart';

enum MetricType { cpu, ram, network }

class MetricTile extends StatelessWidget {
  const MetricTile({
    required this.title,
    required this.unit,
    required this.metric,
    required this.icon,
    super.key,
  });

  final String title;
  final String unit;
  final MetricType metric;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Selector<DashboardViewModel, double>(
      selector: (_, vm) {
        final data = vm.currentMetrics;
        return switch (metric) {
          MetricType.cpu => data.cpu,
          MetricType.ram => data.ram,
          MetricType.network => data.network,
        };
      },
      builder: (context, value, _) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: Theme.of(context).colorScheme.primary),
                    const Spacer(),
                    Text(title, style: Theme.of(context).textTheme.labelLarge),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  '${value.toStringAsFixed(1)} ${unit == '%' ? '%' : unit}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: (value / (metric == MetricType.network ? 120 : 100)).clamp(0.0, 1.0),
                    minHeight: 7,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
