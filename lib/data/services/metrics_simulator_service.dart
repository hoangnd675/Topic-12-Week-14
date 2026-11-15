import 'dart:math';

import '../../domain/models/device.dart';
import '../../domain/models/system_metrics.dart';

class MetricsSimulatorService {
  MetricsSimulatorService() : _random = Random();

  final Random _random;

  SystemMetrics nextMetrics() {
    return SystemMetrics(
      cpu: 18 + _random.nextDouble() * 70,
      ram: 35 + _random.nextDouble() * 50,
      network: 8 + _random.nextDouble() * 90,
      updatedAt: DateTime.now(),
    );
  }

  List<Device> nextDevices(List<Device> current) {
    return current.map((device) {
      final roll = _random.nextInt(20);
      final status = roll == 0
          ? DeviceStatus.offline
          : roll < 4
              ? DeviceStatus.warning
              : DeviceStatus.online;
      return device.copyWith(
        status: status,
        load: 15 + _random.nextInt(80),
      );
    }).toList(growable: false);
  }
}
