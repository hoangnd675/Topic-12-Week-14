import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/dashboard_view_model.dart';
import '../viewmodels/theme_view_model.dart';
import '../widgets/device_list.dart';
import '../widgets/metric_chart.dart';
import '../widgets/metric_tile.dart';
import '../widgets/provider_explainer.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 900;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.monitor_heart_outlined),
            SizedBox(width: 10),
            Text('SYSTEM MONITOR'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Đổi giao diện',
            onPressed: context.read<ThemeViewModel>().toggleTheme,
            icon: const Icon(Icons.contrast),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildHeading(context),
                const SizedBox(height: 22),
                const _MonitoringControls(),
                const SizedBox(height: 18),
                const _OverviewCards(),
                const SizedBox(height: 18),
                if (isWide)
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: MetricChart()),
                      SizedBox(width: 18),
                      Expanded(flex: 2, child: DeviceList()),
                    ],
                  )
                else ...[
                  const MetricChart(),
                  const SizedBox(height: 18),
                  const DeviceList(),
                ],
                const SizedBox(height: 18),
                const ProviderExplainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeading(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tổng quan hệ thống', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(
          'Theo dõi trạng thái thiết bị và hiệu năng theo thời gian thực.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _MonitoringControls extends StatelessWidget {
  const _MonitoringControls();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Row(
          children: [
            Selector<DashboardViewModel, bool>(
              selector: (_, vm) => vm.isMonitoring,
              builder: (context, running, _) => Icon(
                Icons.circle,
                size: 11,
                color: running ? Colors.green : Colors.grey,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Consumer<DashboardViewModel>(
                builder: (context, viewModel, _) => Text(
                  viewModel.isMonitoring ? 'Đang giám sát' : 'Đã tạm dừng',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            IconButton(
              tooltip: 'Cập nhật ngay',
              onPressed: context.read<DashboardViewModel>().refreshNow,
              icon: const Icon(Icons.refresh),
            ),
            const SizedBox(width: 8),
            FilledButton.icon(
              onPressed: context.read<DashboardViewModel>().toggleMonitoring,
              icon: const Icon(Icons.pause, size: 18),
              label: const Text('Bật / Tắt'),
            ),
          ],
        ),
      ),
    );
  }
}

class _OverviewCards extends StatelessWidget {
  const _OverviewCards();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final count = constraints.maxWidth < 560 ? 1 : 3;
        final width = (constraints.maxWidth - (count - 1) * 12) / count;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            SizedBox(width: width, child: const MetricTile(title: 'CPU', unit: '%', metric: MetricType.cpu, icon: Icons.memory)),
            SizedBox(width: width, child: const MetricTile(title: 'RAM', unit: '%', metric: MetricType.ram, icon: Icons.storage)),
            SizedBox(width: width, child: const MetricTile(title: 'NETWORK', unit: 'Mbps', metric: MetricType.network, icon: Icons.wifi)),
          ],
        );
      },
    );
  }
}
