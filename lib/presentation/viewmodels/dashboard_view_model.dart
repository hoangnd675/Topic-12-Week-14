import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../data/services/metrics_simulator_service.dart';
import '../../domain/models/device.dart';
import '../../domain/models/system_metrics.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel({required MetricsSimulatorService simulator})
      : _simulator = simulator,
        _metrics = [
          SystemMetrics(
            cpu: 42,
            ram: 58,
            network: 31,
            updatedAt: DateTime.now(),
          ),
        ];

  final MetricsSimulatorService _simulator;
  final List<SystemMetrics> _metrics;
  Timer? _timer;
  bool _isMonitoring = false;
  int _updateCount = 0;

  List<Device> _devices = const [
    Device(name: 'Gateway Core', type: 'Router', ipAddress: '192.168.1.1', status: DeviceStatus.online, load: 32),
    Device(name: 'Database Node', type: 'Server', ipAddress: '192.168.1.10', status: DeviceStatus.online, load: 61),
    Device(name: 'Access Point 01', type: 'Network', ipAddress: '192.168.1.21', status: DeviceStatus.warning, load: 78),
    Device(name: 'Storage Node', type: 'Storage', ipAddress: '192.168.1.30', status: DeviceStatus.online, load: 44),
  ];

  SystemMetrics get currentMetrics => _metrics.last;
  List<SystemMetrics> get history => List.unmodifiable(_metrics);
  List<Device> get devices => List.unmodifiable(_devices);
  bool get isMonitoring => _isMonitoring;
  int get updateCount => _updateCount;
  int get onlineCount =>
      _devices.where((d) => d.status == DeviceStatus.online).length;
  int get warningCount =>
      _devices.where((d) => d.status == DeviceStatus.warning).length;
  int get offlineCount =>
      _devices.where((d) => d.status == DeviceStatus.offline).length;

  void startMonitoring() {
    if (_isMonitoring) return;
    _isMonitoring = true;
    _timer = Timer.periodic(
      const Duration(seconds: 2),
      (_) => _refreshMetrics(),
    );
    notifyListeners();
  }

  void stopMonitoring() {
    _timer?.cancel();
    _timer = null;
    _isMonitoring = false;
    notifyListeners();
  }

  void toggleMonitoring() {
    _isMonitoring ? stopMonitoring() : startMonitoring();
  }

  void refreshNow() => _refreshMetrics(force: true);

  void _refreshMetrics({bool force = false}) {
    if (!_isMonitoring && !force) return;

    _metrics.add(_simulator.nextMetrics());
    if (_metrics.length > 24) {
      _metrics.removeAt(0);
    }
    _devices = _simulator.nextDevices(_devices);
    _updateCount++;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
