import 'package:flutter/material.dart';

import '../models/products_model.dart';
import '../services/woocommerce_service.dart';

class ProductsProvider extends ChangeNotifier {
  List<ProductsModel> products = [];
  final Map<ProductsModel, int> userCart = {};
  final WooCommerceService _service = WooCommerceService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchProductsFromAPI() async {
    _isLoading = true;
    notifyListeners();

    try {
      products = await _service.fetchProducts();
    } catch (e) {
      debugPrint("Error fetching products: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  List<ProductsModel> getProductList() => products;

  Map<ProductsModel, int> getUserCart() => userCart;

  void addItemToCart(ProductsModel product) {
    if (userCart.containsKey(product)) {
      userCart[product] = userCart[product]! + 1;
    } else {
      userCart[product] = 1;
    }
    notifyListeners();
  }

  void removeFromCart(ProductsModel product) {
    if (!userCart.containsKey(product)) return;

    if (userCart[product]! > 1) {
      userCart[product] = userCart[product]! - 1;
    } else {
      userCart.remove(product);
    }
    notifyListeners();
  }

  void removeProductCompletely(ProductsModel product) {
    userCart.remove(product);
    notifyListeners();
  }

  int get totalCartItems {
    return userCart.values.fold(0, (sum, qty) => sum + qty);
  }
}
