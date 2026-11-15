import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/device.dart';
import '../viewmodels/dashboard_view_model.dart';

class DeviceList extends StatelessWidget {
  const DeviceList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Thiết bị', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            Selector<DashboardViewModel, List<Device>>(
              selector: (_, vm) => vm.devices,
              builder: (context, devices, _) => Column(
                children: devices.map((device) => _DeviceRow(device: device)).toList(),
              ),
            ),
            const Divider(height: 24),
            const _DeviceSummary(),
          ],
        ),
      ),
    );
  }
}

class _DeviceRow extends StatelessWidget {
  const _DeviceRow({required this.device});

  final Device device;

  @override
  Widget build(BuildContext context) {
    final color = switch (device.status) {
      DeviceStatus.online => Colors.green,
      DeviceStatus.warning => Colors.orange,
      DeviceStatus.offline => Colors.red,
    };
    final status = switch (device.status) {
      DeviceStatus.online => 'Online',
      DeviceStatus.warning => 'Warning',
      DeviceStatus.offline => 'Offline',
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(Icons.dns_outlined, size: 18, color: color),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(device.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text('${device.type} • ${device.ipAddress}', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(status, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
              Text('${device.load}% tải', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}

class _DeviceSummary extends StatelessWidget {
  const _DeviceSummary();

  @override
  Widget build(BuildContext context) {
    return Selector<DashboardViewModel, (int, int, int)>(
      selector: (_, vm) => (vm.onlineCount, vm.warningCount, vm.offlineCount),
      builder: (context, counts, _) => Wrap(
        spacing: 14,
        runSpacing: 8,
        children: [
          _SummaryItem(label: 'Online', count: counts.$1, color: Colors.green),
          _SummaryItem(label: 'Warning', count: counts.$2, color: Colors.orange),
          _SummaryItem(label: 'Offline', count: counts.$3, color: Colors.red),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({required this.label, required this.count, required this.color});

  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, size: 8, color: color),
        const SizedBox(width: 5),
        Text('$label: $count', style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
