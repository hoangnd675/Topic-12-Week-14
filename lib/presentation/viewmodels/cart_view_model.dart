import 'package:flutter/foundation.dart';
import '../../data/repositories/product_repository.dart';
import '../../domain/models/product.dart';

class CartViewModel extends ChangeNotifier {
  CartViewModel({ProductRepository repository = const ProductRepository()}) : _products = repository.getProducts();
  final List<Product> _products;
  final Map<String, int> _quantities = {};
  String _category = 'Tất cả';
  List<Product> get products => List.unmodifiable(_products);
  String get category => _category;
  List<String> get categories => ['Tất cả', ...{..._products.map((p) => p.category)}];
  List<Product> get visibleProducts => _category == 'Tất cả' ? products : _products.where((p) => p.category == _category).toList();
  int get itemCount => _quantities.values.fold(0, (sum, value) => sum + value);
  double get total => _products.fold(0, (sum, p) => sum + p.price * (_quantities[p.id] ?? 0));
  int quantityFor(Product product) => _quantities[product.id] ?? 0;

  void selectCategory(String value) {
    if (_category == value) return;
    _category = value;
    notifyListeners();
  }
  void add(Product product) {
    _quantities.update(product.id, (value) => value + 1, ifAbsent: () => 1);
    notifyListeners();
  }
  void remove(Product product) {
    final current = quantityFor(product);
    if (current <= 1) {
      _quantities.remove(product.id);
    } else {
      _quantities[product.id] = current - 1;
    }
    notifyListeners();
  }
  void clearCart() {
    _quantities.clear();
    notifyListeners();
  }
}
