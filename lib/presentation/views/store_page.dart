import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/models/product.dart';
import '../viewmodels/cart_view_model.dart';
import '../viewmodels/theme_view_model.dart';
import '../widgets/product_card.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});
  String money(double value) => value.toStringAsFixed(0) + ' đ';

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Store', style: TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
            tooltip: 'Đổi giao diện',
            onPressed: context.read<ThemeViewModel>().toggleTheme,
            icon: Icon(context.watch<ThemeViewModel>().isDark ? Icons.light_mode : Icons.dark_mode),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Center(child: Selector<CartViewModel, int>(
              selector: (_, model) => model.itemCount,
              builder: (_, count, __) => Badge(label: Text('$count'), child: const Icon(Icons.shopping_bag_outlined, size: 25)),
            )),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Text('Cửa hàng demo', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
              Text('Provider + ChangeNotifier • MVVM • Clean Code', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              const SizedBox(height: 22),
              _CartSummary(total: money(cart.total), count: cart.itemCount),
              const SizedBox(height: 22),
              const Text('Danh mục sản phẩm', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Wrap(spacing: 8, children: cart.categories.map((category) => ChoiceChip(
                label: Text(category), selected: cart.category == category,
                onSelected: (_) => context.read<CartViewModel>().selectCategory(category),
              )).toList()),
              const SizedBox(height: 18),
              LayoutBuilder(builder: (context, constraints) {
                final columns = constraints.maxWidth >= 850 ? 3 : constraints.maxWidth >= 540 ? 2 : 1;
                return GridView.builder(
                  shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                  itemCount: cart.visibleProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columns, crossAxisSpacing: 14, mainAxisSpacing: 14, mainAxisExtent: 205),
                  itemBuilder: (_, index) => ProductCard(product: cart.visibleProducts[index]),
                );
              }),
              const SizedBox(height: 24),
              _CartDetails(money: money),
              const SizedBox(height: 16),
              const _ConceptNote(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartSummary extends StatelessWidget {
  const _CartSummary({required this.total, required this.count});
  final String total;
  final int count;
  @override
  Widget build(BuildContext context) => Card(child: Padding(
    padding: const EdgeInsets.all(18),
    child: Row(children: [
      const Icon(Icons.shopping_cart_checkout, size: 30),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Tổng thanh toán', style: TextStyle(fontSize: 13)),
        Text(total, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
      ])),
      Text('$count món', style: const TextStyle(fontWeight: FontWeight.w600)),
    ]),
  ));
}

class _CartDetails extends StatelessWidget {
  const _CartDetails({required this.money});
  final String Function(double) money;
  @override
  Widget build(BuildContext context) => Consumer<CartViewModel>(builder: (context, cart, _) {
    final entries = cart.products.where((p) => cart.quantityFor(p) > 0).toList();
    return Card(child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Expanded(child: Text('Giỏ hàng', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          TextButton.icon(onPressed: cart.itemCount == 0 ? null : cart.clearCart, icon: const Icon(Icons.delete_outline), label: const Text('Xóa giỏ')),
        ]),
        if (entries.isEmpty)
          const Padding(padding: EdgeInsets.symmetric(vertical: 14), child: Text('Chưa có sản phẩm. Hãy bấm “Thêm vào giỏ”.'))
        else
          ...entries.map((Product p) => ListTile(
            contentPadding: EdgeInsets.zero, leading: Text(p.emoji, style: const TextStyle(fontSize: 25)),
            title: Text(p.name),
            subtitle: Text(cart.quantityFor(p).toString() + ' × ' + money(p.price)),
            trailing: Text(money(p.price * cart.quantityFor(p)), style: const TextStyle(fontWeight: FontWeight.bold)),
          )),
        const Divider(),
        Row(children: [
          const Expanded(child: Text('Tổng cộng', style: TextStyle(fontWeight: FontWeight.bold))),
          Text(money(cart.total), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        ]),
      ]),
    ));
  });
}

class _ConceptNote extends StatelessWidget {
  const _ConceptNote();
  @override
  Widget build(BuildContext context) => const Card(child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Điểm cần trình bày', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('• MultiProvider: đăng ký CartViewModel và ThemeViewModel.'),
      Text('• ChangeNotifierProvider: cung cấp từng ViewModel.'),
      Text('• Consumer: cập nhật khu vực giỏ hàng khi state thay đổi.'),
      Text('• Selector: chỉ rebuild huy hiệu số lượng sản phẩm.'),
      Text('• context.watch/read: lắng nghe state hoặc gọi action.'),
    ]),
  ));
}
