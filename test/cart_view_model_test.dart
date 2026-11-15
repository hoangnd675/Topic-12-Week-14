import 'package:flutter_test/flutter_test.dart';
import 'package:topic12_provider_demo/domain/models/product.dart';
import 'package:topic12_provider_demo/presentation/viewmodels/cart_view_model.dart';

void main() {
  group('CartViewModel', () {
    late CartViewModel model;
    late Product product;
    setUp(() {
      model = CartViewModel();
      product = model.products.first;
    });
    test('adds product and updates count and total', () {
      model.add(product);
      expect(model.itemCount, 1);
      expect(model.total, product.price);
    });
    test('removes product and clears cart', () {
      model.add(product);
      model.add(product);
      model.remove(product);
      expect(model.quantityFor(product), 1);
      model.clearCart();
      expect(model.itemCount, 0);
      expect(model.total, 0);
    });
    test('filters products by category', () {
      model.selectCategory('Gia dụng');
      expect(model.visibleProducts.every((p) => p.category == 'Gia dụng'), isTrue);
    });
  });
}
