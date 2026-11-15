import 'package:flutter_test/flutter_test.dart';
import 'package:topic12_provider_dashboard/data/services/metrics_simulator_service.dart';
import 'package:topic12_provider_dashboard/presentation/viewmodels/dashboard_view_model.dart';

void main() {
  group('DashboardViewModel', () {
    late DashboardViewModel viewModel;

    setUp(() {
      viewModel = DashboardViewModel(
        simulator: MetricsSimulatorService(),
      );
    });

    tearDown(() {
      viewModel.dispose();
    });

    test('starts with initial metrics and devices', () {
      expect(viewModel.history, hasLength(1));
      expect(viewModel.devices, hasLength(4));
      expect(viewModel.updateCount, 0);
    });

    test('notifies listeners when monitoring starts and stops', () {
      var notifications = 0;
      viewModel.addListener(() => notifications++);

      viewModel.startMonitoring();
      expect(viewModel.isMonitoring, isTrue);
      viewModel.stopMonitoring();
      expect(viewModel.isMonitoring, isFalse);
      expect(notifications, 2);
    });
  });
}
