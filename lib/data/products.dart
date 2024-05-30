import 'package:flutter/material.dart';
import 'package:nike/models/products_model.dart';

class Products extends ChangeNotifier {
  List<ProductsModel> products = [
    ProductsModel(
        name: 'watch cx-29',
        price: '240',
        imagePath: 'assets/images/products/watch.png',
        description: 'The watch description'),
    ProductsModel(
        name: 'shoe cb-36',
        price: '278',
        imagePath: 'assets/images/products/shoes.png',
        description: 'The shoe description'),
    ProductsModel(
        name: 'glasses dx-47',
        price: '320',
        imagePath: 'assets/images/products/glasses.png',
        description: 'The glasses description'),
    ProductsModel(
        name: 'hoodie lx-39',
        price: '245',
        imagePath: 'assets/images/products/hoodie.png',
        description: 'The hoodie description'),
  ];

  // Logics for user cart
  List<ProductsModel> userCart = [];

  // Get list of products for sale
  List<ProductsModel> getProductList() {
    return products;
  }

  // Get user cart
  List<ProductsModel> getUserCart() {
    return userCart;
  }

  // Add items to user cart
  void addItemToCart(ProductsModel products) {
    userCart.add(products);
    notifyListeners();
  }

  // Remove from cart
  void removeFromCart(ProductsModel product) {
    userCart.remove(product);
    notifyListeners();
  }
}
