import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/dashboard_view_model.dart';

class ProviderExplainer extends StatelessWidget {
  const ProviderExplainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MINI LAB: PROVIDER & CHANGENOTIFIER',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Các widget bên dưới cùng đọc một nguồn trạng thái DashboardViewModel. '
                'Khi ViewModel gọi notifyListeners(), các widget đang lắng nghe sẽ nhận thay đổi.'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                _StateProbe(label: 'Selector A'),
                _StateProbe(label: 'Selector B'),
                _StateProbe(label: 'Selector C'),
                _WatchProbe(),
              ],
            ),
            const SizedBox(height: 14),
            const Text('Thử bấm “Cập nhật ngay” ở phía trên và quan sát cả ba widget cùng đổi số.'),
            const SizedBox(height: 12),
            const _CodeHint(),
          ],
        ),
      ),
    );
  }
}

class _StateProbe extends StatelessWidget {
  const _StateProbe({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Selector<DashboardViewModel, int>(
      selector: (_, vm) => vm.updateCount,
      builder: (context, count, _) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Text('$label • lần $count'),
      ),
    );
  }
}

class _WatchProbe extends StatelessWidget {
  const _WatchProbe();

  @override
  Widget build(BuildContext context) {
    final updateCount = context.watch<DashboardViewModel>().updateCount;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: Text('context.watch • lần $updateCount'),
    );
  }
}

class _CodeHint extends StatelessWidget {
  const _CodeHint();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: const SelectableText(
        'context.watch<T>()  → đọc state và rebuild widget khi thay đổi\n'
        'context.read<T>()   → gọi hàm, không đăng ký lắng nghe\n'
        'Consumer<T>()       → lắng nghe trong một vùng UI cụ thể\n'
        'Selector<T, R>()    → chỉ rebuild khi giá trị được chọn đổi\n'
        'notifyListeners()   → phát tín hiệu state đã thay đổi',
        style: TextStyle(fontFamily: 'monospace', height: 1.6),
      ),
    );
  }
}
