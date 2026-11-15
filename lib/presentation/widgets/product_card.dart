import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/models/product.dart';
import '../viewmodels/cart_view_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) => Card(clipBehavior: Clip.antiAlias, child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(width: 48, height: 48, alignment: Alignment.center,
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.circular(12)),
          child: Text(product.emoji, style: const TextStyle(fontSize: 25))),
        const Spacer(), Text(product.category, style: Theme.of(context).textTheme.labelSmall),
      ]),
      const SizedBox(height: 12),
      Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Text(product.description, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall),
      const Spacer(),
      Row(children: [
        Expanded(child: Text(product.price.toStringAsFixed(0) + ' đ', style: const TextStyle(fontWeight: FontWeight.w800))),
        FilledButton.tonalIcon(onPressed: () => context.read<CartViewModel>().add(product),
          icon: const Icon(Icons.add_shopping_cart, size: 17), label: const Text('Thêm')),
      ]),
    ]),
  ));
}
