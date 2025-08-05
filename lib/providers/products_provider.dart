import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductsProvider extends ChangeNotifier {
  final List<Product> _products = [];
  final Map<Product, int> _userCart = {};

  // This method must exist and be public
  Map<Product, int> getUserCart() => userCart;

  // Expose cart items
  Map<Product, int> get userCart => _userCart;

  // Expose cart item count
  int get totalCartItems {
    return _userCart.values.fold(0, (sum, qty) => sum + qty);
  }

  // Cart operations
  void addItemToCart(Product product) {
    if (_userCart.containsKey(product)) {
      _userCart[product] = _userCart[product]! + 1;
    } else {
      _userCart[product] = 1;
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    if (!_userCart.containsKey(product)) return;

    if (_userCart[product]! > 1) {
      _userCart[product] = _userCart[product]! - 1;
    } else {
      _userCart.remove(product);
    }
    notifyListeners();
  }

  void removeProductCompletely(Product product) {
    _userCart.remove(product);
    notifyListeners();
  }

  // Optional (in case you want to use static product list for other pages)
  List<Product> get productList => _products;
}
